From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 00:04:15 +0200
Message-ID: <200707040004.16357.oliver__8646.9346810647$1183500561$gmane$org@neukum.org>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707032348.42796.oliver@neukum.org>
	<1183499792.3388.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183499792.3388.16.camel@localhost.localdomain>
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
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 3. Juli 2007 schrieb Benjamin Herrenschmidt:
> On Tue, 2007-07-03 at 23:48 +0200, Oliver Neukum wrote:
> > Am Dienstag, 3. Juli 2007 schrieb Benjamin Herrenschmidt:
> > > On Tue, 2007-07-03 at 21:32 +0200, Oliver Neukum wrote:
> > > > > I'm not sure why this can't be made atomic, but assuming, that it
> > > > > can't, fuse should still not need to be implicated.  If it is,
> > > > that's
> > > > > an indication about something wrong in the suspend procedure.
> > > > 
> > > > Nope, something's wrong in fuse. You must be able to deal with sync
> > > > until every task is frozen. 
> > > 
> > > Pipe dream
> > 
> > Then tell me how you want to avoid that condition.
> 
> Don't freeze :-)

Then you will have to deal with all syscalls unfrozen tasks can make.

	Regards
		Oliver
