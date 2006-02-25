From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Bug#354254: hibernate: Suspend to disk doesn't work:
	cannot find swap device
Date: Sat, 25 Feb 2006 02:02:07 +0100
Message-ID: <200602250202.08033.rjw@sisk.pl>
References: <E1FCnSx-0000u7-00@porton.narod.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <E1FCnSx-0000u7-00@porton.narod.ru>
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
To: Victor Porton <porton@ex-code.com>
Cc: Debian Bug Tracking System <submit@bugs.debian.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Saturday 25 February 2006 01:39, Victor Porton wrote:
> On 24-Feb-2006 Rafael J. Wysocki wrote:
> >> Suspend to disk does not work for me with the following dmesg message:
> >> 
> >> PM: writing image.
> >> swsusp: cannot find swap device, try swapon -a.
> >> 
> > I think you haven't used the "resume=<your_swap_partition>" kernel command
> > line argument, which is mandatory for suspend with this kernel.
> 
> I have used resume=/dev/swap
> 
> /dev/swap is a symlink to /dev/hda2

I don't think the code that uses this argument is capable of following
symlinks.  Please use resume=/dev/hda2 and see if that helps.

Greetings,
Rafael
