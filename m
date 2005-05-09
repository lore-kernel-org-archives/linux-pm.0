From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 2.6.12-rc4] pm diagnostics update,
	check for errors
Date: Mon, 9 May 2005 11:52:17 +0200
Message-ID: <20050509095217.GB19790@atrey.karlin.mff.cuni.cz>
References: <200505081715.20470.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6923338117897786=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200505081715.20470.david-b@pacbell.net>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============6923338117897786==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> I've had this for a while, and converting to a GIT repository is
> incentive enough to send it out.  Mostly it just makes existing
> diagnostics be more useful, but it also adds some error checking
> for cases that can happen on non-trivial systems ... or when
> userspace actions through /sys/.../power/state files break some
> system integrity rules.
> 
> If nobody objects, I'll probably ask to merge this at some point.

Patch is good, but merging it is going to be slightly tricky because
I'll need to touch the same area just after
2.6.12... (pm_message_t-becomes-struct will conflict in trivial way).

I could create pm_message_t-becomes-struct patch early, and put it
into good-git repository so that you could put your patch on the top
of that. Would that work for you?

[Another alternative is make this go in *real fast* so that it gets in
before 2.6.12 and I can place my patch on the top of that.]
								Pavel


-- 
Boycott Kodak -- for their patent abuse against Java.

--===============6923338117897786==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============6923338117897786==--
