From: Mark Gross <mgross@linux.intel.com>
Subject: Re: cpufreq terminally broken [was Re: community PM
	requirements/issues and PowerOP]
Date: Thu, 14 Sep 2006 08:04:14 -0700
Message-ID: <20060914150414.GB6008@linux.intel.com>
References: <20060911082025.GD1898@elf.ucw.cz>
	<b0623b9bb79afacc77cddc6e39c96b62@nomadgs.com>
	<20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com>
	<20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com>
	<20060911225617.GB13474@elf.ucw.cz>
	<20060912001701.GC14234@linux.intel.com>
	<20060912083328.GA19197@elf.ucw.cz>
	<acd2a5930609120210w7ee5a156s5fa5bbc59aeabad8@mail.gmail.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <acd2a5930609120210w7ee5a156s5fa5bbc59aeabad8@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>, Preece Scott-PREECE <scott.preece@motorola.com>, kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 12, 2006 at 01:10:24PM +0400, Vitaly Wool wrote:
> Pavel,
> =

> On 9/12/06, Pavel Machek <pavel@ucw.cz> wrote:
> >Can we at least try adding that, before deciding cpufreq is unsuitable
> >and starting new interface? I do not think issues are nearly as big as
> >you think.. (at user<->kernel interface level, anyway; you'll need big
> >changes under the hood).
> =

> who talks about user <-> kernel interface level changes at the moment?!
>

Mostly Pavel is.

There are questions on how to set/get operating points between the
platform and user space, and some questions on one to make the space of
operating points extensible outside of compile time deployment nice.
But these questions aren't the ones I see folks fussing about.

--mgross
