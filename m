From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: [RFC] A New Power Management API
Date: Fri, 15 Apr 2005 09:50:03 -0600
Message-ID: <20050415095003.52f3185a@cosmic.amd.com>
References: <1113533193.3451.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2804860376196141=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1113533193.3451.40.camel@localhost.localdomain>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============2804860376196141==
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit

Adam - 

Nice stuff.  A few comments.  First, a question:

Is it safe to assume that PMU devices  (like these:
 http://www.dialog-semiconductor.com/template.php?page_id=62) would fall
under the category of Power Resources?  if so, we may need to consider
some more advanced hooks than just on/off.

Secondly, I have some comments regarding the system states, especially
the last three.  While those three states are important, right off the
bat I can think of several scenarios where additional power states could
be imagined.  I fear that if we hard code these states, then every
individual with a slightly different usage model on a given platform
would have to patch the kernel accordingly.  This isn't such a far
fetched scenario on an embedded platform.

This is where I see the policy managers taking a greater role.  In
addition to the hard coded states (the first five you defined sound fine
to me), the user would define a number of pseudo system states as well
as define the translation tables for device states under those pseudo
states. Each pseudo state would be registered with the PM core and
assigned a unique identifier.

We would then define a system state flag, say
PM_SYSTEM_STATE_PSEUDO, which would prompt a driver to query its policy
manager to get the translation for the right device state.  Those
devices that don't understand or care about user defined power
states would simply ignore the flag.

I think that way we could keep things simple for for the laptop /
desktop folks while still providing a bit of flexibility on the embedded
side of things.

Regards,
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>






 


--===============2804860376196141==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============2804860376196141==--
