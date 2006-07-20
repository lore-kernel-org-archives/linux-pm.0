From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: [RFC] PowerOP Take 3, ARM OMAP1 platform support 3/5
Date: Fri, 21 Jul 2006 00:01:44 +0400
Message-ID: <c55240ed0607201301y7ac3be76o6f173d1b6ab50c1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_49685_27519709.1153425704290"
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: patrick.mochel@intel.com, Matthew Locke <matt@nomadgs.com>, linux@dominikbrodowski.net, sampsa.fabritius@nokia.com
List-Id: linux-pm@vger.kernel.org

------=_Part_49685_27519709.1153425704290
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

PowerOP support for OMAP1 platforms.  Currently handles these power
parameters:

  v                 voltage (in mV)
  dpll              dpll frequency in kHz
  cpu              cpu frequency in kHz
  tc                 traffic controller frequency in kHz
  per               peripherial frequency in kHz
  dsp              dsp frequency in kHz
  dspmmu      dsp mmu frequency in kHz
  lcd               LCD frequency in kHz

Example usage will be shown with a follow-on OMAP1 PM Core and cpufreq
patches.

------=_Part_49685_27519709.1153425704290
Content-Type: text/x-patch; name="OMAP1.arch.PowerOP.support.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="OMAP1.arch.PowerOP.support.patch"
X-Attachment-Id: f_epvjvidg

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWFybS9hcmNoLW9tYXAvcG93ZXJvcC5oIGIvaW5jbHVk
ZS9hc20tYXJtL2FyY2gtb21hcC9wb3dlcm9wLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXgg
MDAwMDAwMC4uMzkxZTE2NQotLS0gL2Rldi9udWxsCisrKyBiL2luY2x1ZGUvYXNtLWFybS9hcmNo
LW9tYXAvcG93ZXJvcC5oCkBAIC0wLDAgKzEsMzQgQEAKKy8qCisgKiBQb3dlck9QIHN1cHBvcnQg
Zm9yIE9NQVAxCisgKgorICogQmFzZWQgb24gRFBNIE9NQVAgY29kZSBieSBNYXR0aGV3IExvY2tl
LCBEbWl0cnkgQ2hpZ2lyZXYsIFZsYWRpbWlyCisgKiBCYXJpbm92LCBhbmQgVG9kZCBQb3lub3Iu
CisgKgorICogMjAwNSAoYykgTW9udGFWaXN0YSBTb2Z0d2FyZSwgSW5jLiBUaGlzIGZpbGUgaXMg
bGljZW5zZWQgdW5kZXIKKyAqIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExp
Y2Vuc2UgdmVyc2lvbiAyLiBUaGlzIHByb2dyYW0KKyAqIGlzIGxpY2Vuc2VkICJhcyBpcyIgd2l0
aG91dCBhbnkgd2FycmFudHkgb2YgYW55IGtpbmQsIHdoZXRoZXIgZXhwcmVzcworICogb3IgaW1w
bGllZC4KKyAqLworCisjaWZuZGVmIF9fQVNNX0FSQ0hfT01BUF9QT1dFUk9QX0hfXworI2RlZmlu
ZSBfX0FTTV9BUkNIX09NQVBfUE9XRVJPUF9IX18KKworLyogCisgKiBJbnN0YW5jZXMgb2YgdGhp
cyBzdHJ1Y3R1cmUgZGVmaW5lIG9wZXJhdGluZyBwb2ludHMKKyAqCisgKiAtMSBmb3IgYW55IGZv
bGxvd2luZyBmaWVsZHMgaW5kaWNhdGVzIG5vIGNoYW5nZSBmcm9tIGN1cnJlbnQgb3AgCisgKi8K
Kworc3RydWN0IHBvd2Vyb3BfcG9pbnQgeworCXVuc2lnbmVkIGludCB2OyAgICAgICAgIC8qIHZv
bHRhZ2UgaW4gbVYgKi8KKwl1bnNpZ25lZCBpbnQgZHBsbDsJLyogaW4gS0h6ICovCisJdW5zaWdu
ZWQgaW50IGNwdTsJLyogQ1BVIGZyZXF1ZW5jeSBpbiBLSHogKi8KKwl1bnNpZ25lZCBpbnQgdGM7
CS8qIGluIEtIeiAqLworCXVuc2lnbmVkIGludCBwZXI7CS8qIGluIEtIeiAqLworCXVuc2lnbmVk
IGludCBkc3A7CS8qIGluIEtIeiAqLworCXVuc2lnbmVkIGludCBkc3BtbXU7CS8qIGluIEtIeiAq
LworCXVuc2lnbmVkIGludCBsY2Q7CS8qIGluIEtIeiAqLworfTsKKworI2VuZGlmIC8qIF9fQVNN
X0FSQ0hfT01BUF9QT1dFUk9QX0hfXyAqLworCmRpZmYgLS1naXQgYS9pbmNsdWRlL2FzbS1hcm0v
cG93ZXJvcC5oIGIvaW5jbHVkZS9hc20tYXJtL3Bvd2Vyb3AuaApuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwLi5jMTA5MGU2Ci0tLSAvZGV2L251bGwKKysrIGIvaW5jbHVkZS9hc20t
YXJtL3Bvd2Vyb3AuaApAQCAtMCwwICsxLDE5IEBACisvKgorICogaW5jbHVkZS9hc20tYXJtL3Bv
d2Vyb3AuaAorICoKKyAqIENvcHlyaWdodCAyMDA2IChjKSBFdWdlbnkgUy4gTWludHMgPGV1Z2Vu
eS5taW50c0BnbWFpbC5jb20+LiAKKyAqIAorICogVGhpcyBmaWxlIGlzIGxpY2Vuc2VkIHVuZGVy
ICB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyAKKyAqIExpY2Vuc2UgdmVyc2lv
biAyLiBUaGlzIHByb2dyYW0gaXMgbGljZW5zZWQgImFzIGlzIiB3aXRob3V0IGFueSAKKyAqIHdh
cnJhbnR5IG9mIGFueSBraW5kLCB3aGV0aGVyIGV4cHJlc3Mgb3IgaW1wbGllZC4KKyAqLworI2lm
bmRlZiBfX0FTTV9QT1dFUk9QX0hfXworI2RlZmluZSBfX0FTTV9QT1dFUk9QX0hfXworCisvKgor
ICogaW5jbHVkZSBzdWItYXJjaCBzcGVjaWZpYyBiaXRzCisgKi8KKyNpbmNsdWRlIDxhc20vYXJj
aC9wb3dlcm9wLmg+CisKKyNlbmRpZiAvKiBfX0FTTV9QT1dFUk9QX0hfXyAqLworCg==
------=_Part_49685_27519709.1153425704290
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


------=_Part_49685_27519709.1153425704290--
