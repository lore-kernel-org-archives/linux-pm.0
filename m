From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 04 Jul 2007 07:35:18 +1000
Message-ID: <1183498518.3388.12.camel__4051.56622077829$1183498890$gmane$org@localhost.localdomain>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031709.29968.rjw@sisk.pl> <200707031920.59940.oliver@neukum.org>
	<200707032259.59714.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707032259.59714.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> I don't think that would matter.
> 
> Still, I can remove the sync from the suspend code path only, leaving it in
> the hibernation code path.  The patch will be bigger, but well.
> 
> Any objection to that?

Makes sense to sync before suspend tho, to limit the amount of dirty
non-written pages in case things go wrong.

Ben.
