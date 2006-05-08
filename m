From: Richard Hughes <hughsient@gmail.com>
Subject: Re: suspend and hibernate nomenclature
Date: Mon, 08 May 2006 17:09:10 +0100
Message-ID: <1147104551.4071.6.camel@localhost.localdomain>
References: <1147024930.16057.3.camel@localhost.localdomain>
	<20060508150512.GJ4761@cosmic.amd.com>
Reply-To: richard@hughsie.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1589514009740467=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060508150512.GJ4761@cosmic.amd.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============1589514009740467==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2006-05-08 at 09:05 -0600, Jordan Crouse wrote:
> On 07/05/06 19:02 +0100, Richard Hughes wrote:
> > First, sorry for the random mail to this mailing list.
> > 
> > I'm the developer of gnome-power-manager. The latest mini-project of
> > mine is to fix the suspend-hibernate nomenclature used by OSS projects.
> > 
> > This might not effect the lowest layers of the stack (i.e. I want to
> > focus on the stuff used by *users*), so this might not be applicable to
> > you guys. 
> 
> I would say thats probably a pretty accurate assessment.  Since you are a GUI
> developer, you can tell the users whatever you want, and you can translate
> under the scenes.  In that case, using terms like "hibernate" makes perfect 
> sense.

Sure, agreed.

> But at the lower level, I favor a more clinical terminology, because it
> reduces confusion amongst system developers. Thats not to say that our 
> current terminology is sane, (because it isn't), but I would far prefer
> precise numbers over vague synonyms for sleeping. :)

Up to you guys :-)

> *Our* task, as I see it, is to make sure that the underlying descriptions
> are intelligent and persistent, so *you* don't have to change your 
> application every time something a new kernel is released.  But as soon as
> we've figured that out, then it will be no thing for you to take an
> "hibernate" from the top end, and turn it into the right term for the kernel.

Sure, I totally agree the user shouldn't know about any of this stuff,
but I thought I should bring the website to your attention to keep you
guys in the loop with GUI users... :-)

Anyway, thanks for this mail, feedback has been great so far.

Richard.


--===============1589514009740467==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1589514009740467==--
