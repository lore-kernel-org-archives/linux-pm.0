From: Dmitry Shachnev <mitya57@debian.org>
Subject: Re: [PATCH] cpupower: Install cpupower.h as a public header file
Date: Tue, 17 Oct 2017 22:53:47 +0300
Message-ID: <20171017195347.uhqsjstxx3qha53u@mitya57.me>
References: <20171016185004.zyq6eugwedc34f7l@mitya57.me>
 <2594649.cpXK6EFXZg@skinner>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cxbguimorbndvq23"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:57214 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbdJQTxw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2017 15:53:52 -0400
Received: by mail-lf0-f66.google.com with SMTP id 90so3315414lfs.13
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2017 12:53:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2594649.cpXK6EFXZg@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-pm@vger.kernel.org


--cxbguimorbndvq23
Content-Type: multipart/mixed; boundary="3jd4g3glmymezbx3"
Content-Disposition: inline


--3jd4g3glmymezbx3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Thomas!

On Tue, Oct 17, 2017 at 10:29:23AM +0200, Thomas Renninger wrote:
> On Monday, October 16, 2017 09:50:04 PM Dmitry Shachnev wrote:
> > This helps software that uses cpupower_is_cpu_online function, such as
> > gnome-applets.
>
> Can you give it a try or confirm that the CPU topology list/functions also
> work as intended if used as an external library, please.
> And whether they are written to be easily used and understood or whether
> the interface could still be enhanced.
>
> If things work as expected by others, it's certainly a good idea to publish
> these.

With the attached little test program, I get this result:

cores = 0, pkgs = 1, threads per code = 0
core 0: pkg = 0, core = 0, cpu = 0, online = 1
core 1: pkg = 0, core = 1, cpu = 1, online = 1

cores is always 0, but that is explained in a comment in cpupower.c.
threads is never assigned any value, I assume this can be implemented later?

The rest of output looks fine to me, though I am not going to use this API
so I cannot really judge.

--
Dmitry Shachnev

--3jd4g3glmymezbx3
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="test_cpupower.c"

#include <stdio.h>
#include <cpupower.h>

int main() {
    struct cpupower_topology cpu_top;
    int cpus = get_cpu_topology (&cpu_top);
    printf("cores = %u, pkgs = %u, threads per code = %u\n",
           cpu_top.cores, cpu_top.pkgs, cpu_top.threads);
    for (int i = 0; i < cpus; ++i) {
        struct cpuid_core_info *info = cpu_top.core_info + i;
        printf("core %d: pkg = %d, core = %d, cpu = %d, online = %u\n",
               i, info->pkg, info->core, info->cpu, info->is_online);
    }
    cpu_topology_release(cpu_top);
}

--3jd4g3glmymezbx3--

--cxbguimorbndvq23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEbEPcK+5mZmLK5jNU1v5xA2P4XdMFAlnmX8UACgkQ1v5xA2P4
XdOXaxAAppDfd9MhaB1WiOlOXnZN/N0DR31Ci8fGa0EwuEct5jQy0Z7vE6BuJctk
1gPtRK5yfJM6f83xbWMQzs4Ceop6TfZ9eBh6yzR3pfK69Hnf5AmHdzxujHv/LamS
VtDpDtPu1+W3LL9Upcl2OSULKAWNGmJUEFMRfjJAmCR3UVqo5cya6NCr+mhNzQbv
14OxVRrkHyOsBxGRQ7Dokuhp20V+8S8J8egDNmjHVJUeOZ64VD1YoY/zvjk69ISE
crk+5EK5BUYKzuxFmSh4td2IePeKkrX81ltTSsm0IOhJqFoFjehfIAFlIzK0drHp
XsbTTn6TOBzcPDgfC3idGqPK0n5/cBKtHzbpMvQn3CuklMAocV+gwX/HWH+mKz7M
hOcIZc38g9h6+v5xQPCEU7tujnVRU9hoYaEKrQm2QxFU7AevANNiymBw2aDbBN5l
oMdyRy7UoVmpEV8AlSClafrO2EjKwcNJenMXr3TKQlliIDervQ9zemBioJh86wVe
gxdJjnAr1xS5yfgffrPEK3+IbNn6eD5PhSowzofkENwqT764GKTUK78CWktsckgI
5hN0VeIahdIzpD0zuCgEPMTY+jFNeazcG+6zuWfIxMbXs1RvtwaR3JyRv934tZWs
OVorRTZwLskPqnnviNh+PzKgbUXPXmEkHs6fL/mLaUxJVQAW7vY=
=XrRg
-----END PGP SIGNATURE-----

--cxbguimorbndvq23--
