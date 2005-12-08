From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/RFT] suspend from userland
Date: Thu, 8 Dec 2005 23:52:07 +0100
Message-ID: <200512082352.07659.rjw@sisk.pl>
References: <20051207011753.GA2526@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051207011753.GA2526@elf.ucw.cz>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday, 7 December 2005 02:17, Pavel Machek wrote:
> I'd like to get some testing and comments on this. I know that
> userland part is messy and will not work on x86-64 etc, and I should
> obviously remove some extra printk's... but otherwise it should be okay.
> 
> Testing would be nice, too, but be a bit careful. It should not be
> more dangerous than /sys/power/resume, but... If you suspect something
> unusual, be sure to force fsck.

Could we please postpone it for some time?

First, the patch doesn't apply to the current -mm and the userland part is
incompatible with the code there to the extent of a serious breakage
(let alone the x86-64 issue).

Second, if I had some time to get my solution ready, we could compare the
alternatives instead of just discussing one of them.

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
