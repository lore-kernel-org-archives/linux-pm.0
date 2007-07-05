From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 14:29:06 +0200
Message-ID: <200707051429.07535.rjw@sisk.pl>
References: <20070703211227.GA28758@srcf.ucam.org>
	<200707041717.05149.rjw@sisk.pl>
	<18060.15209.274437.471074@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18060.15209.274437.471074@cargo.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: mjg59@srcf.ucam.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

On Thursday, 5 July 2007 02:29, Paul Mackerras wrote:
> Rafael J. Wysocki writes:
> 
> > They will not trigger 100% of the time, but sporadically and generally at
> > random.
> > 
> > At least the freezer problems are reproducible. ;-)
> 
> Our experience with powermacs has been that it isn't actually all that
> hard to get it right for the drivers you care about.

Well, I'm a bit suspicious about that. ;-)

Namely, if you run your suspend code on one CPU and (do I remeber correctly
that?) with kernel preemption disabled, then you practically prevent user land
processes from being scheduled when your suspend code is running.

If that is the case (of which I'm not sure), the freezer is obviously
unnecessary, because you've taken processes out of the equation in a different
way ...

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
