From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: suspend and hibernate nomenclature
Date: Mon, 8 May 2006 09:05:12 -0600
Message-ID: <20060508150512.GJ4761@cosmic.amd.com>
References: <1147024930.16057.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============69824085597528152=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1147024930.16057.3.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: richard@hughsie.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============69824085597528152==
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On 07/05/06 19:02 +0100, Richard Hughes wrote:
> First, sorry for the random mail to this mailing list.
> 
> I'm the developer of gnome-power-manager. The latest mini-project of
> mine is to fix the suspend-hibernate nomenclature used by OSS projects.
> 
> This might not effect the lowest layers of the stack (i.e. I want to
> focus on the stuff used by *users*), so this might not be applicable to
> you guys. 

I would say thats probably a pretty accurate assessment.  Since you are a GUI
developer, you can tell the users whatever you want, and you can translate
under the scenes.  In that case, using terms like "hibernate" makes perfect 
sense.

But at the lower level, I favor a more clinical terminology, because it
reduces confusion amongst system developers. Thats not to say that our 
current terminology is sane, (because it isn't), but I would far prefer
precise numbers over vague synonyms for sleeping. :)

*Our* task, as I see it, is to make sure that the underlying descriptions
are intelligent and persistent, so *you* don't have to change your 
application every time something a new kernel is released.  But as soon as
we've figured that out, then it will be no thing for you to take an
"hibernate" from the top end, and turn it into the right term for the kernel.

Regards,
Jordan

--
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>


--===============69824085597528152==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============69824085597528152==--
