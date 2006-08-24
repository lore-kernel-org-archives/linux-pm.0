From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC] PowerOP, PowerOP Core 1/3
Date: Thu, 24 Aug 2006 10:04:49 +0200
Message-ID: <20060824080449.GH1952@elf.ucw.cz>
References: <44D7EA4D.1020001@gmail.com> <20060815203756.GI4032@ucw.cz>
	<44E4EC5A.4090201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <44E4EC5A.4090201@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> >>+/* =

> >>+ * powerop_register_point - add new operating point with a given name =
to
> >>+ * operating points list. A caller passes power parameters for new =

> >>operating
> >>+ * points as pairs of name/value and passes only those parameter names =

> >>the
> >>+ * caller is interested in. PowerOP Core calls powerop driver to =

> >>initialize
> >>+ * arch dependent part of new operating point and links new named =

> >>operating + * point to the list maintained by PowerOP Core
> >>+ * =

> >>+ *
> >>+ * INPUT
> >>+ *   id         - operating point name
> >>+ *   pwr_params - set of (power parameter name, value) pairs
> >>+ *
> >>+ * OUTPUT
> >>+ *   none
> >>+ *
> >>+ * RETURN
> >>+ *   zero on success, error code otherwise
> >>+ *    =

> >>+ */
> >>+int =

> >>+powerop_register_point(const char *id, const char *pwr_params, ...)
> >
> >kzalloc?
> >
> >Why do we want one more string parser in kernel?
> >  =

> referencing power parameters by name  interface is result of  gradual =

> evolution of PowerOP interface mainly in order to address the =

> requirement to be truly arch independent interface and to get rid of =

> sharing an arch dependent data structures (a structure which defines =

> operating point for a certain platform) between layers on top and =

> beneath PowerOP (see the picture of the layers; thus a layer which =

> creates operating points with help of PowerOP don't need to include arch =

> dependent definition of operating point structure from PM Core layer). =

> The latter fixes the overall PM architecture with OOP design concept.

We need better solution. Putting string parser into kernel because you
feel OOP is nice is bad idea. See vfs for example of OOP-like design
without string parsers.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
