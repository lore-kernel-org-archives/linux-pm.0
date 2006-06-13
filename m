From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/2] Add some basic resume trace facilities
Date: Tue, 13 Jun 2006 16:13:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606131612250.5498@g5.osdl.org>
References: <5389061B65D50446B1783B97DFDB392D01623F6F@orsmsx411.amr.corp.intel.com>
	<Pine.LNX.4.64.0606131551210.5498@g5.osdl.org>
	<20060613230445.GB22300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060613230445.GB22300@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dave Jones <davej@redhat.com>
Cc: linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org



On Tue, 13 Jun 2006, Dave Jones wrote:
>
> On Tue, Jun 13, 2006 at 03:59:57PM -0700, Linus Torvalds wrote:
> =

>  > The real-time clock was literally the only thing I could find that did=
n't =

>  > get cleared, and that obviously has some serious limitations size-wise.
> =

> Hmm, do they even clear all of video ram on a reset ?

As far as I can tell, yes. Definitely the parts I looked at.

(This is an integrated video device, so "video ram" is just a part of =

system ram, set aside by the BIOS for the graphics).

			Linus
