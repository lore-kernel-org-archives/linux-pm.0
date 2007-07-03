From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 04 Jul 2007 09:08:31 +1000
Message-ID: <1183504112.3388.45.camel__4036.16441549293$1183504399$gmane$org@localhost.localdomain>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707032348.42796.oliver@neukum.org>
	<1183499792.3388.16.camel@localhost.localdomain>
	<200707040004.16357.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707040004.16357.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2007-07-04 at 00:04 +0200, Oliver Neukum wrote:
> Am Dienstag, 3. Juli 2007 schrieb Benjamin Herrenschmidt:
> > On Tue, 2007-07-03 at 23:48 +0200, Oliver Neukum wrote:
> > > Am Dienstag, 3. Juli 2007 schrieb Benjamin Herrenschmidt:
> > > > On Tue, 2007-07-03 at 21:32 +0200, Oliver Neukum wrote:
> > > > > > I'm not sure why this can't be made atomic, but assuming, that it
> > > > > > can't, fuse should still not need to be implicated.  If it is,
> > > > > that's
> > > > > > an indication about something wrong in the suspend procedure.
> > > > > 
> > > > > Nope, something's wrong in fuse. You must be able to deal with sync
> > > > > until every task is frozen. 
> > > > 
> > > > Pipe dream
> > > 
> > > Then tell me how you want to avoid that condition.
> > 
> > Don't freeze :-)
> 
> Then you will have to deal with all syscalls unfrozen tasks can make.

Yup, and the majority of them is totally harmless. Looks like people
around here have a problem with the idea of writing robust drivers ...

Ben.
