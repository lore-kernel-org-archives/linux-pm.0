From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] [PATCH] Power Managed memory base enabling
Date: Mon, 26 Mar 2007 12:48:46 +0000
Message-ID: <20070326124846.GC11088@ucw.cz>
References: <20070305181826.GA21515@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070305181826.GA21515@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Gross <mgross@linux.intel.com>
Cc: linux-mm@kvack.org, mark.gross@intel.com, linux-pm@lists.osdl.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, neelam.chandwani@intel.com
List-Id: linux-pm@vger.kernel.org

Hi!

> It implements a convention on the 4 bytes of "Proximity Domain ID"
> within the SRAT memory affinity structure as defined in ACPI3.0a.  If
> bit 31 is set, then the memory range represented by that PXM is assumed
> to be power managed.  We are working on defining a "standard" for
> identifying such memory areas as power manageable and progress committee
> based.  =

...
> More will be done, but for now we would like to get this base enabling
> into the upstream kernel as an initial step.

I'm not sure if the hack above does not disqualify it from
mainstream...

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
