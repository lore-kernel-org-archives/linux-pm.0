From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: RE: [RFC] change suspend_finish order slightly
Date: Tue, 6 Dec 2005 07:09:39 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F10102F4BD@pdsmsx406>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============29713085161173391=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ncunningham@cyclades.com
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============29713085161173391==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

Hi,
>
>On Sat, 2005-12-03 at 13:15, Shaohua Li wrote:
>> The BIOS guys here require ACPI _WAK method which is called in
>> pm_ops->finish is invoked after all CPUs are resumed. Detail info can
be
>> found at http://bugzilla.kernel.org/show_bug.cgi?id=5651. To do this,
>> this patch tries to change the order slightly. Does this break other
>> platforms?
>
>Is it needed even if you call the prepare after hot unplugging other
>cpus? (If so, I need to modify suspend2, too).
Yes. The ACPI _WAK method requires all CPU are booted per the BIOS guys.

Thanks,
Shaohua


--===============29713085161173391==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============29713085161173391==--
