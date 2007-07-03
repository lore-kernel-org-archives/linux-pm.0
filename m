From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 23:09:13 +0200
Message-ID: <200707032309.13966.rjw@sisk.pl>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031709.29968.rjw@sisk.pl>
	<200707032026.34649.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707032026.34649.oliver@neukum.org>
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
To: Oliver Neukum <oliver@neukum.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 3 July 2007 20:26, Oliver Neukum wrote:
> Am Dienstag, 3. Juli 2007 schrieb Rafael J. Wysocki:
> > > > The main reason for deadlocks is because we do a sys_sync() after the
> > > > freeze, which we shouldn't do.
> > > 
> > > So why don't we remove the sys_sync() from freeze_processes() instead?
> > 
> > The patch follows (untested).
> 
> And a further question. The freezer is not atomic. What do you do
> if a task not yet frozen calls sys_sync(), but fuse is already frozen?

Hmm, if the sync is interruptible (I'm not sure), the task should be frozen while
waiting for it to complete.

Otherwise, the freezing of tasks will fail (no deadlock).

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
