From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: PowerOP, Intro 0/3
Date: Wed, 4 Oct 2006 23:26:28 -0400
Message-ID: <20061005032628.GB18228@dominikbrodowski.de>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DD01A948CF@de01exm64.ds.mot.com>
	<dfc4e6d130c1725cbac211fa940a4d5d@nomadgs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <dfc4e6d130c1725cbac211fa940a4d5d@nomadgs.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matt@nomadgs.com>
Cc: pm list <linux-pm@lists.osdl.org>, Preece Scott-PREECE <scott.preece@motorola.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Matthew,

Nitpicking, I know, but:

On Tue, Aug 29, 2006 at 12:28:21AM -0700, Matthew Locke wrote:
> PowerOP does not automatically lead to an explosion of states/points.  =

> As you can see from the cpufreq patches, PowerOP provides the same =

> number points currently available in cpufreq.

- Also the ~64.000 points[*] currently available in gx-suspmod.c ?
- Also the intervals + "mode" currently available in and for longrun.c ?

Thanks,
	Dominik


[*] rough calculation. Might be significantly lower, but it's definitely in
    the 1E5 area.
