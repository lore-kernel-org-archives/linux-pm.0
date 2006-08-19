From: "David Singleton" <daviado@gmail.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Fri, 18 Aug 2006 23:10:02 -0700
Message-ID: <b324b5ad0608182310v348f8936j527357e60c3a77bb@mail.gmail.com>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com> <20060815010020.GA14251@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_16318_32557822.1155967802859"
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060815010020.GA14251@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

------=_Part_16318_32557822.1155967802859
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/14/06, Greg KH <greg@kroah.com> wrote:
> On Mon, Aug 14, 2006 at 07:48:01PM -0400, Dave Jones wrote:
> >
> > This adds a whole bunch of new code, and doesn't seem to make any
> > existing code any simpler (to me at least).  From a cpufreq point of view,
> > what does adding this buy us? What problem do we have today that is
> > being solved by all this?

Greg and Dave,

                 there are two competing patch sets for a new power management
        framework.   The patch set I sent out simplifies power management,
        from both the cpufreq perspective and the embedded world's view of
        power management.

                I've renamed my patch oppoint so as not confuse it
        with the powerop set from Matt Locke (which will probably make
        it even more confusing).  I've renamed it so it can be seen as an
        alternative design approach, not just an alternative implementation
        of the same ideas.  I've also incorporated suggestions from
        Pavel in cleaning up the original patches.

                If you'd be willing to take a look at, or try out, the patches
        in my patch set you should be able to see how oppoint could simplify
        cpufreq code.  The first patch is the oppoint-cpufreq.patch and
        the second is the oppoint-x86-centrino.patch.

                Oppoint could replace large pieces of the cpufreq code
        in the kernel, most notably the policy and governor code, which I
        believe belongs in user space in the power manager daemon.

                You'll notice that the oppoint-cpufreq.patch only touches
        two files, cpufreq.c and cpufreq.h. It only creates two new interfaces
        to the cpufreq frequency scaling notifier lists to support driver pre
        and post scaling routines, already supported in the kernel.

                The oppoint-x86-centrino.patch completes the replacement
        of cpufreq code by introducing the transition routine to
        change frequencies and creates operating points for the
        centrino-speedstep processors already supported by Linux.

        (although I've recieved a note from Intel that the data I've copied
        from the centrino-speedstep cpufreq tables is known to be inaccurate
        and unsupported)

                This code could replace cpufreq code and simplify it quite a
        bit in the process.  The kernel drivers that support cpufreq frequency
        scaling would not have to be changed.  Operating points for the rest
        of the processors that support cpufreq would have to be created, but
        as you can see it's quite a straight forward transformation from
        a cpufreq table to a set of operating points for a processor.

                The entire patch set can be found at:

                http://source.mvista.com/~dsingleton/2.6.18-rc4/

        The patch set consists of:

                oppoint-core.patch
                oppoint-cpufreq.patch
                oppoint-x86-centrino.patch
                oppoint-arm-pxa27x.patch

        I'll attach oppoint-cpufreq.patch  to this email and
        send out oppoint-x86-centrino.patch next.


David



> >
> > Every explanation of powerop I've seen so far dives into microdetails,
> > whilst the 10,000ft view has always passed me by other than "this is
> > what we've had in the embedded world".
> >
> > The diagram at http://lists.osdl.org/pipermail/linux-pm/2006-August/003196.html
> > also confuses me.  I was under the impression that powerop was adding additional
> > userspace interfaces.  If we're not changing how things from a userspace
> > point of view, we're churning a lot of kernel code,.. why?
> >
> > Clue me in here, I'm feeling thick.
>
> You're not alone, I really don't get it either.
>
> But I guess we'll just wait for the next round of unified patches and
> then go from there.
>
> thanks,
>
> greg k-h
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
>

------=_Part_16318_32557822.1155967802859
Content-Type: application/octet-stream; name=oppoint-cpufreq.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_a9z88c
Content-Disposition: attachment; filename="oppoint-cpufreq.patch"

ClNpZ25lZC1PZmYtYnk6IERhdmlkIFNpbmdsZXRvbiA8ZHNpbmdsZXRvbkBtdmlzdGEuY29tPgoK
IGRyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMgfCAgIDM2ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwogaW5jbHVkZS9saW51eC9jcHVmcmVxLmggICB8ICAgIDIgKysKIDIgZmls
ZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKQoKSW5kZXg6IGxpbnV4LTIuNi4xNy9kcml2ZXJz
L2NwdWZyZXEvY3B1ZnJlcS5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi4xNy5vcmlnL2RyaXZl
cnMvY3B1ZnJlcS9jcHVmcmVxLmMKKysrIGxpbnV4LTIuNi4xNy9kcml2ZXJzL2NwdWZyZXEvY3B1
ZnJlcS5jCkBAIC0yMjYsNiArMjI2LDM1IEBAIHN0YXRpYyB2b2lkIGFkanVzdF9qaWZmaWVzKHVu
c2lnbmVkIGxvbmcKIHN0YXRpYyBpbmxpbmUgdm9pZCBhZGp1c3RfamlmZmllcyh1bnNpZ25lZCBs
b25nIHZhbCwgc3RydWN0IGNwdWZyZXFfZnJlcXMgKmNpKSB7IHJldHVybjsgfQogI2VuZGlmCiAK
K2ludCBjcHVmcmVxX3ByZXBhcmVfdHJhbnNpdGlvbihzdHJ1Y3Qgb3Bwb2ludCAqY3VyLCBzdHJ1
Y3Qgb3Bwb2ludCAqbmV3KQoreworCXN0cnVjdCBjcHVmcmVxX2ZyZXFzIGZyZXFzOworCisJZnJl
cXMub2xkID0gY3VyLT5mcmVxdWVuY3k7CisJZnJlcXMubmV3ID0gbmV3LT5mcmVxdWVuY3k7CisJ
ZnJlcXMuY3B1ID0gMDsKKwlmcmVxcy5mbGFncyA9IGNwdWZyZXFfZHJpdmVyLT5mbGFnczsKKwli
bG9ja2luZ19ub3RpZmllcl9jYWxsX2NoYWluKCZjcHVmcmVxX3RyYW5zaXRpb25fbm90aWZpZXJf
bGlzdCwKKwkJCUNQVUZSRVFfUFJFQ0hBTkdFLCAmZnJlcXMpOworCWFkanVzdF9qaWZmaWVzKENQ
VUZSRVFfUFJFQ0hBTkdFLCAmZnJlcXMpOworCXJldHVybiAwOworfQorRVhQT1JUX1NZTUJPTChj
cHVmcmVxX3ByZXBhcmVfdHJhbnNpdGlvbik7CisKK2ludCBjcHVmcmVxX2ZpbmlzaF90cmFuc2l0
aW9uKHN0cnVjdCBvcHBvaW50ICpjdXIsIHN0cnVjdCBvcHBvaW50ICpuZXcpCit7CisJc3RydWN0
IGNwdWZyZXFfZnJlcXMgZnJlcXM7CisKKwlmcmVxcy5vbGQgPSBjdXItPmZyZXF1ZW5jeTsKKwlm
cmVxcy5uZXcgPSBuZXctPmZyZXF1ZW5jeTsKKwlmcmVxcy5jcHUgPSAwOworCWZyZXFzLmZsYWdz
ID0gY3B1ZnJlcV9kcml2ZXItPmZsYWdzOworCWFkanVzdF9qaWZmaWVzKENQVUZSRVFfUE9TVENI
QU5HRSwgJmZyZXFzKTsKKwlibG9ja2luZ19ub3RpZmllcl9jYWxsX2NoYWluKCZjcHVmcmVxX3Ry
YW5zaXRpb25fbm90aWZpZXJfbGlzdCwKKwkJCUNQVUZSRVFfUE9TVENIQU5HRSwgJmZyZXFzKTsK
KwlyZXR1cm4gMDsKK30KK0VYUE9SVF9TWU1CT0woY3B1ZnJlcV9maW5pc2hfdHJhbnNpdGlvbik7
CiAKIC8qKgogICogY3B1ZnJlcV9ub3RpZnlfdHJhbnNpdGlvbiAtIGNhbGwgbm90aWZpZXIgY2hh
aW4gYW5kIGFkanVzdF9qaWZmaWVzCkBAIC05MjAsNiArOTQ5LDEyIEBAIHN0YXRpYyB2b2lkIGNw
dWZyZXFfb3V0X29mX3N5bmModW5zaWduZWQKIH0KIAogCisjaWZkZWYgQ09ORklHX1BNCit1bnNp
Z25lZCBpbnQgY3B1ZnJlcV9xdWlja19nZXQodW5zaWduZWQgaW50IGNwdSkKK3sKKwlyZXR1cm4g
KGN1cnJlbnRfc3RhdGUtPmZyZXF1ZW5jeSAqIDEwMDApOworfQorI2Vsc2UKIC8qKgogICogY3B1
ZnJlcV9xdWlja19nZXQgLSBnZXQgdGhlIENQVSBmcmVxdWVuY3kgKGluIGtIeikgZnJwbSBwb2xp
Y3ktPmN1cgogICogQGNwdTogQ1BVIG51bWJlcgpAQCAtOTQxLDYgKzk3Niw3IEBAIHVuc2lnbmVk
IGludCBjcHVmcmVxX3F1aWNrX2dldCh1bnNpZ25lZCAKIAogCXJldHVybiAocmV0KTsKIH0KKyNl
bmRpZgogRVhQT1JUX1NZTUJPTChjcHVmcmVxX3F1aWNrX2dldCk7CiAKIApJbmRleDogbGludXgt
Mi42LjE3L2luY2x1ZGUvbGludXgvY3B1ZnJlcS5oCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi4x
Ny5vcmlnL2luY2x1ZGUvbGludXgvY3B1ZnJlcS5oCisrKyBsaW51eC0yLjYuMTcvaW5jbHVkZS9s
aW51eC9jcHVmcmVxLmgKQEAgLTI2OCw2ICsyNjgsOCBAQCBzdGF0aWMgaW5saW5lIHVuc2lnbmVk
IGludCBjcHVmcmVxX3F1aWNrCiAJcmV0dXJuIDA7CiB9CiAjZW5kaWYKK2ludCBjcHVmcmVxX3By
ZXBhcmVfdHJhbnNpdGlvbihzdHJ1Y3Qgb3Bwb2ludCAqY3VyLCBzdHJ1Y3Qgb3Bwb2ludCAqbmV3
KTsKK2ludCBjcHVmcmVxX2ZpbmlzaF90cmFuc2l0aW9uKHN0cnVjdCBvcHBvaW50ICpjdXIsIHN0
cnVjdCBvcHBvaW50ICpuZXcpOwogCiAKIC8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioK
------=_Part_16318_32557822.1155967802859
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


------=_Part_16318_32557822.1155967802859--
