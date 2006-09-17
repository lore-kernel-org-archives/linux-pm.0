From: "Vitaly Wool" <vitalywool@gmail.com>
Subject: Re: cpufreq user<->kernel interface removal [was Re:
	community PM requirements/issues and PowerOP]
Date: Sun, 17 Sep 2006 17:10:36 +0400
Message-ID: <acd2a5930609170610l14fef014k54dc60159dcf8703@mail.gmail.com>
References: <20060914162623.GA6867@linux.intel.com>
	<20060917123759.GD2741@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060917123759.GD2741@elf.ucw.cz>
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
Cc: lkml@elf.ucw.cz.kroah.org, Preece Scott-PREECE <scott.preece@motorola.com>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Pavel,

On 9/17/06, Pavel Machek <pavel@ucw.cz> wrote:
> ?? zaurus uses cpufreq just fine, and you could do that on omap. You'd
> not have powersavings coming out of powering down devices, but
> otherwise it should be doable.

I do think you'd better broaden your views here ;)
cpufreq as it is is not well-suitable for complex power management
cases where you need to switch between multiple oscillators/clock
sources/PLLs etc to gain the most efficien power management.
Zaurus is not that complicated in PM AFAIK and I'm sure it could be
even better if it used PowerOP or similar solution. :)

Vitaly
