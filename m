From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: RE: [RFC] change suspend_finish order slightly
Date: Tue, 06 Dec 2005 11:36:15 +1000
Message-ID: <1133832804.6360.40.camel@localhost>
References: <59D45D057E9702469E5775CBB56411F10102F4BD@pdsmsx406>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============79908423095299574=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <59D45D057E9702469E5775CBB56411F10102F4BD@pdsmsx406>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Li Shaohua <shaohua.li@intel.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============79908423095299574==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Tue, 2005-12-06 at 09:09, Li, Shaohua wrote:
> Hi,
> >
> >On Sat, 2005-12-03 at 13:15, Shaohua Li wrote:
> >> The BIOS guys here require ACPI _WAK method which is called in
> >> pm_ops->finish is invoked after all CPUs are resumed. Detail info can
> be
> >> found at http://bugzilla.kernel.org/show_bug.cgi?id=5651. To do this,
> >> this patch tries to change the order slightly. Does this break other
> >> platforms?
> >
> >Is it needed even if you call the prepare after hot unplugging other
> >cpus? (If so, I need to modify suspend2, too).
> Yes. The ACPI _WAK method requires all CPU are booted per the BIOS guys.

Ok. Thanks!

Nigel


--===============79908423095299574==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============79908423095299574==--
