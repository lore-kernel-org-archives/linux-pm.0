From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 13:46:56 +0200
Message-ID: <200707031346.57613.oliver@neukum.org>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707030944.18702.oliver@neukum.org>
	<1183462826.10386.107.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183462826.10386.107.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 3. Juli 2007 schrieb Benjamin Herrenschmidt:
> On Tue, 2007-07-03 at 09:44 +0200, Oliver Neukum wrote:
> > Am Dienstag, 3. Juli 2007 schrieb Benjamin Herrenschmidt:
> > > So to summarize, the plan that makes things work with fuse is:
> > > 
> > >  - For STR, don't do the freezer thing.
> > > 
> > >  - For STD, don't sys_sync() after you froze
> > > 
> > > There might be -other- issues, but that should get you through some of
> > 
> > At the risk of repeating myself. Character device drivers are written
> > with the assumption that normal io and suspend/resume do not race
> > with each other due to the freezer.
> > What do you intend to do about that?
> 
> Ugh ... "character devices" ... that's a pretty wide statement...
> there's lots of those and very different one from the other...

That is a good summary of the problem ;-(

> Any sane device-driver will have to cope with being suspended in a
> "live" system. I've demonstrated multiple times in the past why this is
> necessary anyway, for things like dynamic power management, among
> others.

That is an interesting notion. I'd rather see device drivers reporting
their devices idle and requsting to be suspended.
But in any case it doesn't solve the problem.

	Regards
		Oliver
