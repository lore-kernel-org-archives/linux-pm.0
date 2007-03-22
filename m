From: "Vitaly Wool" <vitalywool@gmail.com>
Subject: Re: + rework-pm_ops-pm_disk_mode-kill-misuse.patch added
	to -mm tree
Date: Thu, 22 Mar 2007 18:23:42 +0300
Message-ID: <acd2a5930703220823m3697cd98i47c3ead8e9fd19bb@mail.gmail.com>
References: <200703212334.l2LNYDjj007030@shell0.pdx.osdl.net>
	<20070322094825.GA29627@flint.arm.linux.org.uk>
	<20070322015614.dafa1ed7.akpm@linux-foundation.org>
	<20070322100355.GA6834@elf.ucw.cz>
	<1174558128.3944.78.camel@johannes.berg>
	<20070322132622.GD29627@flint.arm.linux.org.uk>
	<20070322133117.GC6050@elf.ucw.cz>
	<20070322142437.GB21954@linux-sh.org>
	<1174575945.3588.7.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174575945.3588.7.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 3/22/07, Johannes Berg <johannes@sipsolutions.net> wrote:
> If you have a platform that doesn't allow CONFIG_SOFTWARE_SUSPEND (which
> is only suspend to disk) and doesn't have pm_ops either, then you end up
> with an empty /sys/power/state file.

CONFIG_SOFTWARE_SUSPEND is a misleading name then.

Vitaly
