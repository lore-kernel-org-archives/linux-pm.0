From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 15:18:34 +0100
Message-ID: <200703221518.35286.oneukum@suse.de>
References: <Pine.LNX.4.44L0.0703191135360.14222-100000@iolanthe.rowland.org>
	<200703221444.52065.oneukum@suse.de>
	<20070322135653.GA7693@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070322135653.GA7693@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 22. M=E4rz 2007 14:56 schrieb Pavel Machek:
> > > Generic entry points are for _system_ suspend, and if you try to abuse
> > > them for runtime PM, you'll have to audit/change all the drivers.
> > =

> > Is this your position regarding USB autosuspend, too? Should we use
> > other methods than suspend/resume?
> =

> Well, you should have audited USB drivers when enabling autosuspend...
> But I believe you did that so you are pretty much okay.

We audited them. Respectively, are auditing them.

> (With autosuspend, you can get situation when request from userland
> comes in even when device is suspended; some devices will need
> fixing).

Currently, such requests are ignored. Is there any problem with that?

	Regards
		Oliver
