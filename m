From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm][Experimental] swsusp: freeze
	userspace processes first
Date: Wed, 1 Feb 2006 21:13:56 +0100
Message-ID: <200602012113.56547.rjw@sisk.pl>
References: <200602010141.53974.rjw@sisk.pl> <20060201105505.GB2879@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060201105505.GB2879@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

[Sorry, I was unable to respond earlier.]

On Wednesday 01 February 2006 11:55, Pavel Machek wrote:
> > This is an experimantal patch aimed at the "unable to freeze processes under
> > load" problem.
> > 
> > On my box the 2.6.16-rc1-mm4 kernel with this patch applied survives the
> > "dd if=/dev/hda of=/dev/null" test.
> 
> What filesystem? ext2 vs. ext3 is very different.

Just the entire disk.

> I can fix ext2 by 
> just upping the timeout. ext3 is harder, because of the journalling
> thread. Maybe I'll take the sledgehammer approach and just freeze all
> the user tasks first... I tried to do the "small" approach and just
> fix the journalling code...
> 
> I'm not sure what problem the usermodehelper code is trying to
> solve... why are usermodehelpers special?

They may be waited for uninterruptilby, so we can get an unfreezable proces
if we freeze one of them.

Actually I think I made a mistake here, since call_usermodehelper_keys()
should return -EBUSY rather than 0 when freezing_processes is non-zero
(if we return 0, the caller gets confused, because it assumes the call has
happend and has been successful, which is wrong).

Greetings,
Rafael
