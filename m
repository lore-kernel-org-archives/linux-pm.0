Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117465;
	b=q48a75mHepl6EbtnvUjtpcP2Td55MghYt1CjpmwSTd5N0kvVEQTQsKX9VAyUUW9l2bFd
	 SaCTsVCAdED80dgVg1aGGae6VMX8lly9SwAsdUZVh0sZZ4P2/EAJj1v25SPVhm2KkGipK
	 tjLIMRFiO1dDYzxBW810TStkMo0//xRMNeCkgWKnh6SV7BT/Ii5S9I94bW0oHBmll0vK/
	 UkSM9FuWsjYKpUh2u1NHe+4Q3JX2rjyr/S64onUaeSpzUaufxXHbBinF9mhcMnuhhvs3r
	 D6RwTLVBWWCG9Js0WO8vYPOdMKx57zyvuWmRl1hh89OKp6uPsuciWP1b9LCSHoCUDVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117465;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6HeD0Jh8h3oabJ3kYAzXsF/yIxi0jvf6dYJ2SfddCGw=;
	b=PQg5R42imCL/q5cMnJjZ8Uuh468QuwR4brNrZymxTFnlkZYE6A5CN82hv8E/pbHIAJvd
	 4btpRwTGf3wkBcMA/LbSWdk6ovKaOABqPb7uUizIegdRBMMrEFddhGFO7Z16Q5lQ7cuTk
	 J/S2xIok1BD8lGpGdDvvut1hzk5jfFG7yI6P6VJIm2Am1tlDUs0hGdnY0c4wE3JObYag5
	 9mrIxnnIg05gmV2UV9TnOCJ0rle1qsBf8V4mn6Iy4oDX8+YVsa2L4F8im1v9e0MvI1yqc
	 K57QarAj6ndfVmlJ5zLNKCkyqCs2s9jD6CNuCSxQh98RqaKTIPMRCO5udHgH2BYE/tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7wUe4Lc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C41606A31D
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7wUe4Lc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE1B1F01828
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793117464;
	bh=6HeD0Jh8h3oabJ3kYAzXsF/yIxi0jvf6dYJ2SfddCGw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Q7wUe4LcrRQvGrAY4pHLEgO+v7glylTQDg9MffpdhctudXNwSVu/x331VPNWu7K5k
	 0q1EaV/eI1St83eU6n6FEMeXqNnsgS/+jOk9rL4X5RxQ/4OFRPHKrV8hT4/LIbgOTY
	 daed+E7zRmKIwmtRlkuDKvX+unFYmnRCPAA88adJ6FryV6qQzsd6/Jb44X2axwwiKh
	 rQmrPuRJuNLm+PYnTXAzD7ARCozGUyLoUe+dNcODd1eSG12Nu/euiAidbzhVIpDwQ/
	 zUS8B+4jRxVxw5N+i2jqwuokhEEPS3oU8lSfmf6cAZonNECfHwAjzQqQgc/+SGTUcu
	 W3vcRP+6f81Cg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bccecba199so110085e87.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 09:11:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxjniAF8zHCyBzIGWOMB7jxzRmMYIb5y2QEDzd+TZgPpustp/XFRraqXtFRIfn3BEBVytPcCI+eTA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJgjKxUyqhN6u2fYhxXpzdfQP/fN/RGt1mMGj9k3VqnOYF03bVj
	Bc4mw+P51Tt70l38GvoXRPuH1hPZLPxbZtPq4FK9dHu+oMCGpkeNAswZDp/SHASuXT/RXmZI8HO
	mTx9OvgoaZyNvmlXchCzLmX9MuWmcCOQ=
X-Received: by 2002:a05:6512:400e:b0:5be:494a:8803 with SMTP id
 2adb3069b0e04-5bfb71bf383mr3252885e87.40.1793117462836; Tue, 27 Oct 2026
 09:11:02 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792504834.git.daniel.lezcano@oss.qualcomm.com> <83799bf79e85e9e2ab77140e632f11d96b17a04f.1792504834.git.daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <83799bf79e85e9e2ab77140e632f11d96b17a04f.1792504834.git.daniel.lezcano@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 27 Oct 2026 17:10:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gSLOP4KN3bNB425SaYOLcpJ1c3t5isYEQAdvxqQR0sVQ@mail.gmail.com>
X-Gm-Features: AclHuK_oyFoBc7_HGf0B1_hPw1rqjONuEELwwuuocHstC8eLBQSftjfzINFeD4E
Message-ID: <CAJZ5v0gSLOP4KN3bNB425SaYOLcpJ1c3t5isYEQAdvxqQR0sVQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] selftests/powercap: Add powercap hierarchy
 creation API tests
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rafael@kernel.org, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>, 
	Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Thomas Huth <thuth@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 4:18=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> The powercap hierarchy API introduces generic helpers to duplicate,
> instantiate and destroy a complete powercap hierarchy from a static
> description.
>
> Add a kselftest exercising this API. The test builds a synthetic
> powercap hierarchy composed of a package, three CPU clusters and twelve
> CPUs, registers it as a powercap control type and checks the zone count
> and selected sysfs attribute values. It also checks that the controller
> directory disappears when the module is unloaded.
>
> Exercise direct static creation, duplication, skipped clusters and their
> descendants, reuse after partial destruction, and repeated creation
> returning -EBUSY without replacing existing zone pointers. Callback
> checks verify the controller, name and backend-private data supplied by
> the helpers.
>
> The test consists of:
>
> * a kernel module implementing a synthetic powercap hierarchy and
>   dummy callbacks;
> * a userspace kselftest script that loads the module, checks 16 zones
>   and their power and constraint attributes, unloads the module with an
>   attribute descriptor open, and checks controller removal.
>
> Use powercap-owned zone allocations so registration failures are cleaned
> up by the core. Build generated module files in the selftest output
> directory and extend the common clean target with Kbuild module cleanup.
>
> This provides a regression test for the powercap hierarchy helpers and
> their integration with the powercap core.
>
> Cc: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
> Link: https://patch.msgid.link/20260806110159.69690-3-daniel.lezcano@oss.=
qualcomm.com
> Assisted-by: LLM
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

Sashiko is complaining about this one now:

https://sashiko.dev/#/patchset/cover.1792504834.git.daniel.lezcano%40oss.qu=
alcomm.com

> ---
> Changes in v3 (since v2):
> - Rebase on v7.3-rc7.
> - Use TEST_GEN_FILES and MO=3D$(OUTPUT); preserve the common clean recipe=
.
> - Use powercap-owned allocations for consistent registration cleanup.
> - Keep validation and counting in the main shell so failures propagate.
> - Add static creation, skipped branches, reuse and -EBUSY checks, and
>   hold a sysfs descriptor open across module removal.
> - Document the tests and describe their actual assertions.
> - Fix closing-brace indentation and __initdata placement.
> - Add Assisted-by attribution.
>
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/powercap/Kbuild       |   3 +
>  tools/testing/selftests/powercap/Makefile     |  27 ++
>  .../selftests/powercap/powercap_hierarchy.c   | 305 ++++++++++++++++++
>  .../selftests/powercap/powercap_hierarchy.sh  | 126 ++++++++
>  5 files changed, 462 insertions(+)
>  create mode 100644 tools/testing/selftests/powercap/Kbuild
>  create mode 100644 tools/testing/selftests/powercap/Makefile
>  create mode 100644 tools/testing/selftests/powercap/powercap_hierarchy.c
>  create mode 100755 tools/testing/selftests/powercap/powercap_hierarchy.s=
h
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/M=
akefile
> index bc4fdb6f5337..764cca6182ce 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -104,6 +104,7 @@ TARGETS +=3D pidfd
>  TARGETS +=3D pid_namespace
>  TARGETS +=3D pipe
>  TARGETS +=3D power_supply
> +TARGETS +=3D powercap
>  TARGETS +=3D powerpc
>  TARGETS +=3D prctl
>  TARGETS +=3D proc
> diff --git a/tools/testing/selftests/powercap/Kbuild b/tools/testing/self=
tests/powercap/Kbuild
> new file mode 100644
> index 000000000000..baa0d0ba9593
> --- /dev/null
> +++ b/tools/testing/selftests/powercap/Kbuild
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-m +=3D powercap_hierarchy.o
> \ No newline at end of file
> diff --git a/tools/testing/selftests/powercap/Makefile b/tools/testing/se=
lftests/powercap/Makefile
> new file mode 100644
> index 000000000000..5041ff1acee5
> --- /dev/null
> +++ b/tools/testing/selftests/powercap/Makefile
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# User-space test script
> +TEST_PROGS :=3D powercap_hierarchy.sh
> +
> +# Kernel module built as part of the test
> +TEST_GEN_FILES :=3D powercap_hierarchy.ko
> +
> +KDIR ?=3D $(if $(O),$(O),$(realpath ../../../..))
> +
> +.DEFAULT_GOAL :=3D all
> +
> +include ../lib.mk
> +
> +.PHONY: modules
> +
> +$(OUTPUT)/powercap_hierarchy.ko: modules
> +
> +modules:
> +       $(MAKE) -C $(KDIR) M=3D$(CURDIR) MO=3D$(OUTPUT) modules
> +
> +.PHONY: clean_modules
> +
> +clean: clean_modules
> +
> +clean_modules:
> +       $(MAKE) -C $(KDIR) M=3D$(CURDIR) MO=3D$(OUTPUT) clean
> diff --git a/tools/testing/selftests/powercap/powercap_hierarchy.c b/tool=
s/testing/selftests/powercap/powercap_hierarchy.c
> new file mode 100644
> index 000000000000..baabd2420f9c
> --- /dev/null
> +++ b/tools/testing/selftests/powercap/powercap_hierarchy.c
> @@ -0,0 +1,305 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> + *
> + * Powercap hierarchy description test module
> + *
> + * Test coverage:
> + * - Duplicate an init-only description for use after module initializat=
ion.
> + * - Create and destroy a hierarchy directly from a static initializer.
> + * - Skip a cluster and its children while creating independent branches=
.
> + * - Destroy the partial hierarchy and create the complete hierarchy aga=
in.
> + * - Reject repeated creation with -EBUSY and preserve existing zone poi=
nters.
> + * - Check callback arguments and preservation of backend-private data.
> + *
> + * The complete hierarchy remains registered for powercap_hierarchy.sh t=
o
> + * check its 16 zones and exported attribute values. Module removal dest=
roys
> + * it so the script can check cleanup with a sysfs descriptor still open=
.
> + */
> +#include <linux/powercap.h>
> +#include <linux/string.h>
> +
> +struct pch_test_data {
> +       int value;
> +};
> +
> +static struct powercap_node pch_test_nodes[] __initdata =3D {
> +       [0] =3D { .name =3D "package",
> +               .data =3D &(struct pch_test_data) { .value =3D 0xDEADBEEF=
 } },
> +       [1] =3D { .name =3D "cluster0", .parent =3D &pch_test_nodes[0],
> +               .data =3D &(struct pch_test_data) { .value =3D 0xDEADBEEF=
 } },
> +       [2] =3D { .name =3D "cluster1", .parent =3D &pch_test_nodes[0],
> +               .data =3D &(struct pch_test_data) { .value =3D 0xDEADBEEF=
 } },
> +       [3] =3D { .name =3D "cluster2", .parent =3D &pch_test_nodes[0],
> +               .data =3D &(struct pch_test_data) { .value =3D 0xDEADBEEF=
 } },
> +       [4] =3D { .name =3D "cpu0", .parent =3D &pch_test_nodes[1],
> +               .data =3D &(struct pch_test_data) { .value =3D 0xDEADBEEF=
 } },
> +       [5] =3D { .name =3D "cpu1", .parent =3D &pch_test_nodes[1],
> +               .data =3D &(struct pch_test_data) { .value =3D 0xDEADBEEF=
 } },
> +       [6] =3D { .name =3D "cpu2", .parent =3D &pch_test_nodes[1],
> +               .data =3D &(struct pch_test_data) { .value =3D 0xDEADBEEF=
 } },
> +       [7] =3D { .name =3D "cpu3", .parent =3D &pch_test_nodes[1],
> +               .data =3D &(struct pch_test_data) { .value =3D 0xDEADBEEF=
 } },
> +       [8] =3D { .name =3D "cpu4", .parent =3D &pch_test_nodes[2],
> +               .data =3D &(struct pch_test_data) { .value =3D 0xDEADBEEF=
 } },
> +       [9] =3D { .name =3D "cpu5", .parent =3D &pch_test_nodes[2],
> +               .data =3D &(struct pch_test_data) { .value =3D 0xDEADBEEF=
 } },
> +       [10] =3D { .name =3D "cpu6", .parent =3D &pch_test_nodes[2],
> +               .data =3D &(struct pch_test_data) { .value =3D 0xDEADBEEF=
 } },
> +       [11] =3D { .name =3D "cpu7", .parent =3D &pch_test_nodes[2],
> +               .data =3D &(struct pch_test_data) { .value =3D 0xDEADBEEF=
 } },
> +       [12] =3D { .name =3D "cpu8", .parent =3D &pch_test_nodes[3],
> +               .data =3D &(struct pch_test_data) { .value =3D 0xDEADBEEF=
 } },
> +       [13] =3D { .name =3D "cpu9", .parent =3D &pch_test_nodes[3],
> +               .data =3D &(struct pch_test_data) { .value =3D 0xDEADBEEF=
 } },
> +       [14] =3D { .name =3D "cpu10", .parent =3D &pch_test_nodes[3],
> +               .data =3D &(struct pch_test_data) { .value =3D 0xDEADBEEF=
 } },
> +       [15] =3D { .name =3D "cpu11", .parent =3D &pch_test_nodes[3],
> +               .data =3D &(struct pch_test_data) { .value =3D 0xDEADBEEF=
 } },
> +};
> +
> +static struct powercap_hierarchy pch_test_hierarchy __initdata =3D
> +       POWERCAP_HIERARCHY_INIT(pch_test_hierarchy, pch_test_nodes,
> +                               ARRAY_SIZE(pch_test_nodes));
> +
> +static struct powercap_hierarchy *hierarchy;
> +
> +static struct powercap_control_type *pct;
> +
> +static int pch_test_get_max_power_range_uw(struct powercap_zone *pcz,
> +                                          u64 *power_uw)
> +{
> +       *power_uw =3D 0xBADC0FFEE;
> +       return 0;
> +}
> +
> +static int pch_test_get_power_uw(struct powercap_zone *pcz,
> +                                u64 *power_uw)
> +{
> +       *power_uw =3D 0xC0FFEE;
> +       return 0;
> +}
> +
> +static const struct powercap_zone_ops pch_test_ops =3D {
> +       .get_max_power_range_uw =3D pch_test_get_max_power_range_uw,
> +       .get_power_uw =3D pch_test_get_power_uw,
> +};
> +
> +static int pch_test_set_power_limit_uw(struct powercap_zone *pcz,
> +                                      int cid, u64 power_uw)
> +{
> +       return 0;
> +}
> +
> +static int pch_test_get_power_limit_uw(struct powercap_zone *pcz,
> +                                      int cid, u64 *power_uw)
> +{
> +       *power_uw =3D 0xDEADC0DE;
> +       return 0;
> +}
> +
> +static int pch_test_set_time_window_us(struct powercap_zone *pcz,
> +                                      int cid, u64 power_uw)
> +{
> +       return 0;
> +}
> +
> +static int pch_test_get_time_window_us(struct powercap_zone *pcz,
> +                                      int cid, u64 *power_uw)
> +{
> +       *power_uw =3D 0xDEADC0DE;
> +       return 0;
> +}
> +
> +static int pch_test_get_max_power_uw(struct powercap_zone *pcz,
> +                                    int cid, u64 *power_uw)
> +{
> +       *power_uw =3D 0xDEADC0DE;
> +       return 0;
> +}
> +
> +static const char *pch_test_get_name(struct powercap_zone *pcz, int cid)
> +{
> +       return "my constraint name";
> +}
> +
> +static const struct powercap_zone_constraint_ops pch_test_constraint_ops=
 =3D {
> +       .set_power_limit_uw =3D pch_test_set_power_limit_uw,
> +       .get_power_limit_uw =3D pch_test_get_power_limit_uw,
> +       .set_time_window_us =3D pch_test_set_time_window_us,
> +       .get_time_window_us =3D pch_test_get_time_window_us,
> +       .get_max_power_uw =3D pch_test_get_max_power_uw,
> +       .get_name =3D pch_test_get_name,
> +};
> +
> +static struct powercap_zone *pch_test_create(struct powercap_control_typ=
e *pct,
> +                                            const char *name, void *data=
,
> +                                            struct powercap_zone *parent=
)
> +{
> +       struct pch_test_data *pcht_data =3D data;
> +       struct powercap_zone *pcz;
> +
> +       /* Validate the arguments and private data supplied by the helper=
. */
> +       if (!pct) {
> +               pr_err("Invalid NULL controller type\n");
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       if (!name) {
> +               pr_err("Invalid NULL name\n");
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       if (pcht_data->value !=3D 0xDEADBEEF) {
> +               pr_err("Invalid pcht data !=3D 0xDEADBEEF");
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       pcz =3D powercap_register_zone(NULL, pct, name, parent,
> +                                    &pch_test_ops, 1, &pch_test_constrai=
nt_ops);
> +       if (IS_ERR(pcz)) {
> +               pr_err("Failed to register powercap zone '%s': %ld\n",
> +                      name, PTR_ERR(pcz));
> +       }
> +
> +       return pcz;
> +}
> +
> +static void pch_test_destroy(struct powercap_control_type *pct,
> +                            struct powercap_zone *zone,
> +                            void *data)
> +{
> +       struct pch_test_data *pcht_data =3D data;
> +
> +       /* Destruction must receive the original private data and a valid=
 zone. */
> +       if (!pct) {
> +               pr_err("Invalid NULL controller type\n");
> +               return;
> +       }
> +
> +       if (!zone) {
> +               pr_err("Invalid NULL zone\n");
> +               return;
> +       }
> +
> +       if (pcht_data->value !=3D 0xDEADBEEF) {
> +               pr_err("Invalid pcht data !=3D 0xDEADBEEF");
> +               return;
> +       }
> +
> +       powercap_unregister_zone(pct, zone);
> +}
> +
> +static struct powercap_zone *
> +pch_test_skip_cluster(struct powercap_control_type *pct, const char *nam=
e,
> +                     void *data, struct powercap_zone *parent)
> +{
> +       if (!strcmp(name, "cluster0"))
> +               return NULL;
> +
> +       return pch_test_create(pct, name, data, parent);
> +}
> +
> +static int __init pch_test_init(void)
> +{
> +       struct powercap_zone *zones[ARRAY_SIZE(pch_test_nodes)];
> +       size_t i;
> +       int ret;
> +
> +       /* Keep a runtime copy whose parent pointers survive init memory =
release. */
> +       hierarchy =3D powercap_hierarchy_dup(&pch_test_hierarchy);
> +       if (IS_ERR(hierarchy)) {
> +               ret =3D PTR_ERR(hierarchy);
> +               pr_err("Failed to dup the hierarchy: %d\n", ret);
> +               return ret;
> +       }
> +
> +       pct =3D powercap_register_control_type(NULL, "powercap-test", NUL=
L);
> +       if (IS_ERR(pct)) {
> +               ret =3D PTR_ERR(pct);
> +               pr_err("Failed to register control type: %d\n", ret);
> +               goto out_free_hierarchy;
> +       }
> +
> +       /* Exercise direct creation with a statically initialized hierarc=
hy lock. */
> +       ret =3D powercap_hierarchy_create(pct, &pch_test_hierarchy,
> +                                       pch_test_create, pch_test_destroy=
);
> +       if (ret) {
> +               pr_err("Failed to create the static hierarchy: %d\n", ret=
);
> +               goto out_unregister_pct;
> +       }
> +
> +       powercap_hierarchy_destroy(pct, &pch_test_hierarchy, pch_test_des=
troy);
> +
> +       /* NULL skips cluster0 and its descendants, but not the other clu=
sters. */
> +       ret =3D powercap_hierarchy_create(pct, hierarchy,
> +                                       pch_test_skip_cluster, pch_test_d=
estroy);
> +       if (ret)
> +               goto out_unregister_pct;
> +
> +       for (i =3D 0; i < hierarchy->nr_nodes; i++) {
> +               /* Node 1 is cluster0; nodes 4 through 7 are its four CPU=
s. */
> +               bool skipped =3D i =3D=3D 1 || (i >=3D 4 && i <=3D 7);
> +
> +               if (!!hierarchy->nodes[i].zone =3D=3D skipped) {
> +                       pr_err("Unexpected zone state after skipping clus=
ter0\n");
> +                       ret =3D -EINVAL;
> +                       goto out_destroy_hierarchy;
> +               }
> +       }
> +
> +       /* Partial destruction must leave the hierarchy reusable for a fu=
ll tree. */
> +       powercap_hierarchy_destroy(pct, hierarchy, pch_test_destroy);
> +
> +       ret =3D powercap_hierarchy_create(pct, hierarchy, pch_test_create=
, pch_test_destroy);
> +       if (ret) {
> +               pr_err("Failed to create the hierarchy: %d\n", ret);
> +               goto out_unregister_pct;
> +       }
> +
> +       /* A second creation must return -EBUSY without replacing any zon=
e. */
> +       for (i =3D 0; i < hierarchy->nr_nodes; i++)
> +               zones[i] =3D hierarchy->nodes[i].zone;
> +
> +       ret =3D powercap_hierarchy_create(pct, hierarchy, pch_test_create=
, pch_test_destroy);
> +       if (ret !=3D -EBUSY) {
> +               pr_err("Expected -EBUSY when recreating the hierarchy, go=
t %d\n", ret);
> +               ret =3D -EINVAL;
> +               goto out_destroy_hierarchy;
> +       }
> +
> +       for (i =3D 0; i < hierarchy->nr_nodes; i++) {
> +               if (hierarchy->nodes[i].zone !=3D zones[i]) {
> +                       pr_err("Recreation changed an existing zone\n");
> +                       ret =3D -EINVAL;
> +                       goto out_destroy_hierarchy;
> +               }
> +       }
> +
> +       /* Leave the full tree available for the userspace sysfs checks. =
*/
> +       return 0;
> +
> +out_destroy_hierarchy:
> +       powercap_hierarchy_destroy(pct, hierarchy, pch_test_destroy);
> +out_unregister_pct:
> +       powercap_unregister_control_type(pct);
> +out_free_hierarchy:
> +       powercap_hierarchy_free(hierarchy);
> +       return ret;
> +}
> +module_init(pch_test_init);
> +
> +static void __exit pch_test_exit(void)
> +{
> +       /* Remove zones before their controller; the script checks disapp=
earance. */
> +       powercap_hierarchy_destroy(pct, hierarchy, pch_test_destroy);
> +       powercap_hierarchy_free(hierarchy);
> +       powercap_unregister_control_type(pct);
> +}
> +module_exit(pch_test_exit);
> +
> +MODULE_DESCRIPTION("Powercap hierarchy test driver");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Daniel Lezcano <daniel.lezcano@oss.qualcomm.com");
> diff --git a/tools/testing/selftests/powercap/powercap_hierarchy.sh b/too=
ls/testing/selftests/powercap/powercap_hierarchy.sh
> new file mode 100755
> index 000000000000..6d1394a7d56b
> --- /dev/null
> +++ b/tools/testing/selftests/powercap/powercap_hierarchy.sh
> @@ -0,0 +1,126 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Loading the module runs its in-kernel hierarchy API checks. Then valid=
ate
> +# all 16 exported zones, their power readings and constraint attributes,=
 and
> +# removal of the controller while a sysfs attribute descriptor remains o=
pen.
> +
> +ksft_pass=3D0
> +ksft_fail=3D1
> +ksft_skip=3D4
> +
> +MODULE=3Dpowercap_hierarchy
> +CONTROL=3Dpowercap-test
> +SYSFS=3D/sys/devices/virtual/powercap/$CONTROL
> +
> +fail()
> +{
> +       echo "FAIL: $*"
> +       exit $ksft_fail
> +}
> +
> +skip()
> +{
> +       echo "SKIP: $*"
> +       exit $ksft_skip
> +}
> +
> +cleanup()
> +{
> +       if lsmod | grep -q "^${MODULE}\b"; then
> +               if ! rmmod "$MODULE"; then
> +                       echo "WARNING: failed to unload $MODULE"
> +               fi
> +       fi
> +}
> +
> +trap cleanup EXIT INT TERM
> +
> +[ "$(id -u)" -eq 0 ] || skip "must be run as root"
> +
> +insmod ./powercap_hierarchy.ko || fail "failed to load module"
> +
> +[ -d "$SYSFS" ] || fail "missing $SYSFS"
> +
> +check_zone()
> +{
> +       zone=3D$1
> +
> +       # Check required attributes and the deterministic values from the=
 module.
> +       [ -f "$zone/name" ] || fail "$zone/name missing"
> +
> +       [ -f "$zone/power_uw" ] || \
> +               fail "$zone/power_uw missing"
> +
> +       [ -f "$zone/max_power_range_uw" ] || \
> +               fail "$zone/max_power_range_uw missing"
> +
> +       power=3D$(cat "$zone/power_uw")
> +       [ "$power" =3D "12648430" ] || \
> +               fail "$zone: unexpected power_uw ($power)"
> +
> +       max=3D$(cat "$zone/max_power_range_uw")
> +       [ "$max" =3D "50159747054" ] || \
> +               fail "$zone: unexpected max_power_range_uw ($max)"
> +
> +       constraint=3D"$zone/constraint_0"
> +
> +       name=3D$(cat "$constraint""_name")
> +       [ "$name" =3D "my constraint name" ] || \
> +               fail "$constraint: bad constraint name"
> +
> +       pl=3D$(cat "$constraint""_power_limit_uw")
> +       [ "$pl" =3D "3735929054" ] || \
> +               fail "$constraint: bad power limit"
> +
> +       mp=3D$(cat "$constraint""_max_power_uw")
> +       [ "$mp" =3D "3735929054" ] || \
> +               fail "$constraint: bad max power"
> +}
> +
> +zones=3D0
> +
> +namefiles=3D$(find "$SYSFS" -type f -name name) || fail "failed to list =
zones"
> +
> +while IFS=3D read -r namefile
> +do
> +       zone=3D$(dirname "$namefile")
> +
> +       case "$zone" in
> +               */constraint_*)
> +                       continue
> +                       ;;
> +       esac
> +
> +       check_zone "$zone"
> +
> +       zones=3D$((zones + 1))
> +done <<EOF
> +$namefiles
> +EOF
> +
> +#
> +# Count the number of powercap zones.
> +#
> +[ "$zones" -eq 16 ] || \
> +       fail "expected 16 zones, got $zones"
> +
> +#
> +# Keep an attribute open across module removal, then close it afterwards=
.
> +#
> +exec 3<"$zone/power_uw" || fail "failed to open power_uw before removal"
> +cleanup
> +exec 3<&-
> +
> +#
> +# Verify that the hierarchy disappeared.
> +#
> +if [ -d "$SYSFS" ]; then
> +       fail "$SYSFS still exists after module removal"
> +fi
> +
> +trap - EXIT INT TERM
> +
> +echo "PASS"
> +
> +exit $ksft_pass
> --
> 2.43.0
>
