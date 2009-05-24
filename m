From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2 bugs related to suspend to disk
Date: Mon, 25 May 2009 00:04:11 +0200
Message-ID: <200905250004.11927.rjw__16652.0314677202$1243202810$gmane$org@sisk.pl>
References: <4A199A7A.3010705@gmail.com> <20090524205450.GA1693@elf.ucw.cz>
	<4A19C2A3.6030501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4A19C2A3.6030501@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: Linux PM List <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 24 May 2009, Marcin Slusarz wrote:
> Pavel Machek wrote:
> > Hi!
> > 
> > 
> >> 2) "s2disk" (from suspend-0.8) suspends, but doesn't resume (and I need to mkswap && swapon -a later)
> >>
> > 
> > I'm afraid we need more details here. Is "resume" binary being ran?
> 
> Excellent question ;) - I didn't know it has to. I'll try to setup
> initramfs tomorrow.
> 
> Thanks and sorry for the noise!

However, the issue reported as 1) is not really a noise IMO. :-)

Can you please attach a full dmesg output containing these messages?

Rafael
