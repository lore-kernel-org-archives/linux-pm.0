From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 16:03:10 +1100
Message-ID: <1111640590.16224.180.camel@gaston>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<200503231058.54311.david-b@pacbell.net>
	<1111620276.16224.107.camel@gaston>
	<200503231845.55392.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============63989112523014224=="
In-Reply-To: <200503231845.55392.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============63989112523014224==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-03-23 at 18:45 -0800, David Brownell wrote:

> If you've hogtied your system by forcing some devices ("busses") into
> certain states that prevent others from working, it seems only fair to
> me that it stay hogtied.

No. For example, I'm a host controller. I notice I didn't get any
request for a while, I want to enter a suspended state. That means going
through dependencies of my childs so they can all enter a state
compatible with me going to suspend.

> I suspect you're actually agreeing with me there that some of the
> drivers need flexibility to manage their power states.  And maybe
> even that such modes will be the main ones of interest...
>
> My answer to the question of how those parent/child dependency
> details should be managed was to ensure that the parent can do
> what it needs to.  That is, decentralize those issues.  I don't
> understand why you seem to dislike that approach, when so many
> of your examples seem to confirm it would work.

I want to have the driver in control, yes. But I also want to have a
core that removes the burden from driver writers in the "generic" cases.
It's all a tradeoff to find :)



--===============63989112523014224==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============63989112523014224==--
