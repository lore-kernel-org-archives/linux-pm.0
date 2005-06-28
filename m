From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Suspend "core": what to do now ?
Date: Tue, 28 Jun 2005 14:06:16 +1000
Message-ID: <1119931577.5133.189.camel@gaston>
References: <1119851395.5133.112.camel@gaston>
	<1119912918.30369.7.camel@localhost.localdomain>
	<1119916159.5133.145.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============72899176334243432=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1119916159.5133.145.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <abelay@novell.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============72899176334243432==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-06-28 at 09:49 +1000, Benjamin Herrenschmidt wrote:
> > Let's discuss how we would change the existing PM code...
> > 
> > I was thinking each arch could provide a table of system power states
> > with an ->enter() function for each.  We would then show the names of
> > these states in "/sys/power/state", and the user could select one.  Did
> > you have something else in mind?
> 
> Yes, that's what Patrick suggested too and I agree. 

Ok, It's easy enough as far as suspend to RAM is concerned.
suspend-to-disk is another matter.

I'm not sure what to do with the current crap in there, like the 4
different "methods" etc... that pretty much all assume that the code in
kernel/power/disk.c is "in charge" of the whole process (and it's all
pretty bogus too, like it doesn't deal with sysdev's).

I'm inclined to just trash all of that... but Nigel will have the same
problem here, if I start moving the core of swsusp to arch code, he'll
have to move the core of swsusp2 accordingly.

Also, remains the question then what to do of the resume function. Keep
it there or move it in arch code too... We may want to move it to arch
code too or we'll end up adding hooks to it...

I'm inclined to move everything to arch code, _and_ provide a kind of
"default" implementation of suspend-to-disk that you can enable with a
CONFIG option that provides an enter() callback that you can drop in
your arch it to use "as is" if you don't need any specific callback.

However, PM_DISK_PLATFORM and PM_DISK_FIRMWARE sort-of abuse the pm_ops
that I have killed to call into arch code... it's all crap as it exposes
to all archs some behaviours that may not be supported by those archs.

I'm inclined to just ignore it all and simply kill disk.c and let archs
re-implement what they want, but I'm sure some people will scream if I
do that...

Ben.



--===============72899176334243432==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============72899176334243432==--
