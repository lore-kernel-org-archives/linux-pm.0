From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Suspend "core": what to do now ?
Date: Tue, 28 Jun 2005 09:49:18 +1000
Message-ID: <1119916159.5133.145.camel@gaston>
References: <1119851395.5133.112.camel@gaston>
	<1119912918.30369.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6946908630046158=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1119912918.30369.7.camel@localhost.localdomain>
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

--===============6946908630046158==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> Let's discuss how we would change the existing PM code...
> 
> I was thinking each arch could provide a table of system power states
> with an ->enter() function for each.  We would then show the names of
> these states in "/sys/power/state", and the user could select one.  Did
> you have something else in mind?

Yes, that's what Patrick suggested too and I agree. 

Ben.



--===============6946908630046158==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============6946908630046158==--
