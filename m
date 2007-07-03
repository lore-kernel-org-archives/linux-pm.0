From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 21:32:20 +0200
Message-ID: <200707032132.20731.oliver@neukum.org>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707032026.34649.oliver@neukum.org>
	<E1I5no4-0004fU-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I5no4-0004fU-00@dorka.pomaz.szeredi.hu>
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 3. Juli 2007 schrieb Miklos Szeredi:
> > And a further question. The freezer is not atomic. What do you do
> > if a task not yet frozen calls sys_sync(), but fuse is already frozen?
> 
> What do you do if a task not yet frozen writes to a pipe, on the other
> end of which is a task already frozen?

The same as you do with a pipe when the reader is not ready.

> It doesn't matter.  The only thing that should matter during suspend
> (not hibernate) is saving the state of devices to ram, and putting the
> devices to sleep.

Well, but you did remove sys_sync() from the freezer, which is
and must be called in the hibernate path.
 
> I'm not sure why this can't be made atomic, but assuming, that it
> can't, fuse should still not need to be implicated.  If it is, that's
> an indication about something wrong in the suspend procedure.

Nope, something's wrong in fuse. You must be able to deal with sync
until every task is frozen.

	Regards
		Oliver
