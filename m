From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [RFC 09/15] PM / Hibernate: user,
	implement user_ops writer
Date: Mon, 29 Mar 2010 17:33:20 +0200
Message-ID: <4BB0C840.7030802__37111.0218148262$1269876894$gmane$org@gmail.com>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<201003252314.33256.rjw@sisk.pl> <4BAC7FC3.50405@gmail.com>
	<201003262304.32118.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003262304.32118.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03/26/2010 11:04 PM, Rafael J. Wysocki wrote:
> I have some other comments to this patch, but I'd like to understand what
> really happens here, since the changelog is not too verbose.
> 
> Please explain the design here.

Yeah, my bad.

What I want to achieve is to revert the behaviour of current
implementation to the one used in toi. Now, it is that when writing a
page to the swap, the hibernation does snapshot_read_page(page) with
swap_write_page(page) in a loop. This is OK until one needs to do
anything with the page.

When compression or encryption (or both) are needed to be done, this
scenario does not work well because page returned by snapshot_read_page,
after going through the crypto layers, is no longer PAGE_SIZE big.

Probably the easiest solution is to revert it as noted above: a page is
taken from snapshot (with patches I have here the snapshot layer is only
told to "store next page" without returning a page to the caller), fed
through crypto layers as needed and finally given to chunk writer which
assembles PAGE_SIZE blocks from the chunks. Then whole pages of
compressed/encrypted data are given to user or in-kernel block io by
hibernate_io_ops->write_page. In-kernel .write_page simply calls
swap_write_page (which in turn hib_bio_write_page while storing swap
sector entries).

User .write_page, with buf as a parameter, does the following:
* to_do_buf = buf
* set WORK bit
* wake_up .read (below)
* wait_for WORK bit clear

Writer in this case is a user process performing fops->read. .read does
the following:
* wait_for WORK bit
* copy_to_user to_do_buf
* clear WORK bit
* wake_up .write_page


I need the barrier to ensure the "to_do_buf = buf" assignment is not
reordered with the "set WORK bit" in .write_page. Otherwise .read will
see WORK bit set, but have to_do_buf not updated. I certainly can lock
the two operation together, but (a) I see no point in doing so; (b) it
makes the code worse (I need to unlock and relock in wait_event and
unlock on all fail paths).


The very similar happens for fops->write, ergo hibernate_io_ops->read_page.

thanks,
-- 
js
