From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Linux 2.6.21-rc6
Date: Sat, 14 Apr 2007 22:38:43 +0200
Message-ID: <200704142238.44184.rjw@sisk.pl>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
	<200704142223.32410.rjw@sisk.pl> <20070414202527.GH3691@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070414202527.GH3691@stusta.de>
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
To: Adrian Bunk <bunk@stusta.de>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Tobias Diedrich <ranma@tdiedrich.de>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 14 April 2007 22:25, Adrian Bunk wrote:
> On Sat, Apr 14, 2007 at 10:23:31PM +0200, Rafael J. Wysocki wrote:
> >...
> > Also, would that be feasible for you to use 'shutdown' as a workaround =
in case
> > the source of the problem is difficult to find and/or fix?
> =

> One person reporting a regression against a -rc kernel can mean
> houndreds or thousands of people who will run into the same issue after =

> 2.6.21 got released if a manual workaround is required...

Well, in this particular case it is not very likely to happen.  I have three
x86_64 machines here with totally different chipsets/devices on which I'm
not seeing anything like that and I believe we'd have more reports before
if that were a common issue.

That said, I'm not going to ignore it.  I'll do my best to debug and fix it=
, if
Tobias helps me. :-)

Greetings,
Rafael
