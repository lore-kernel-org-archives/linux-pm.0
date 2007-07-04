From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 10:10:10 +0200
Message-ID: <200707041010.11221.oliver__5290.40805199674$1183536699$gmane$org@neukum.org>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707040004.16357.oliver@neukum.org>
	<1183504112.3388.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183504112.3388.45.camel@localhost.localdomain>
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

Am Mittwoch, 4. Juli 2007 schrieb Benjamin Herrenschmidt:
> > > > > > Nope, something's wrong in fuse. You must be able to deal with sync
> > > > > > until every task is frozen. 
> > > > > 
> > > > > Pipe dream
> > > > 
> > > > Then tell me how you want to avoid that condition.
> > > 
> > > Don't freeze :-)
> > 
> > Then you will have to deal with all syscalls unfrozen tasks can make.
> 
> Yup, and the majority of them is totally harmless. Looks like people
> around here have a problem with the idea of writing robust drivers ...

The majority is meaningless here. The subsystem works or works not.
Reliably failing to work is better than working most of the time.

What I am having a problem with is the rest of the system changing its
behavior and expecting the drivers to cope with that out of the blue.

	Oliver
