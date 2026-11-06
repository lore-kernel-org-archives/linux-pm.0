Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978495;
	b=P3SlehU1t2TVuCO79cN11dEIVabahduAK50IDxg8pa5Y0hehMUUqgasWx6KhQYJHiNqC
	 /0/CnyHqAzk1mP+DeMmzj+pYlnqb5ouNQuvK8mekdHKz5ZgWHGJRrCFAn93mxg5dP/2Sy
	 q6pLLkEg0qqICN5KML2tSiyvJkXq3nu6lYExtZdT4YBGqflvsbh/woPp+yjO+Uu5cxFf8
	 kh4mrFHbKlwYVvAr9XiN9kqnnLeatUwbwRZ5bt53lwxztuyZ0bK9GmrymLkCo6LnR0Q7T
	 7zs8foVOaY5lzFc5dWsABVOuWRRixGugutVvPf1NrtFjnbYueOwrrJIJp1tCEGaUFOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978495;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=20WJXw38AL/aG6uUNEDMZKsUL7v/Bv5b+vJstxx3tDY=;
	b=VcXHc+FdO8t3fP2BfdynXMHqWU1sigppBRnZuA6TdSWdqrHskbLzAIr/lxmHPf0bpVi2
	 RGtoGpj7teLqPLm7Ywbl6oFgADyXX223CEPnoQSbUTYfqq1AVFYJ8FUSFRolHKm6q+EoV
	 SOSD6jaYlnOJQZzEBJyAoRfS+olLr5dbQCnGu8fATINbw/v05nNRE8lOTWpgGJAmdHEQc
	 X3kiE0CFa8su4o25YPTKV0JBN78qxb4R6vcLtWqXIfo9aPz2DDEYUObmj3uxW4xUJguFl
	 xwf5U1DQPdThUpasDwTajprMP+WOP0qeg/yarWhABEAULm3HznsXzuRHu2F2kUGFXag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRk0RvRi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F36F606D80D
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRk0RvRi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4321F008A2
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793978494;
	bh=20WJXw38AL/aG6uUNEDMZKsUL7v/Bv5b+vJstxx3tDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RRk0RvRihoxZqHpctLHHcNOKlSd2iofY2mIJL+faUV77ANc29rjxBfL9wpJWi+ON4
	 t713DAw53wCBWO1uOMHb7aqkA7U4Dwm/WJ4IGINWYngxpoqBYKpQ4ayQzeA7qq0STN
	 NFPIBkGE7sEvGMJsKpoMREWiGjD17Tgj/wgjokdsPEfrkLaA5UlN9Zxg+7vlCRTcXj
	 zuk7o9WcHtdX06WyevEifYOTFuZlnbQWfsZE6zKjhtaNzPXYIABl/tqYb6fr7HSLVI
	 Qwd+1bef9F/KcYfDMDLbhE1HCpf8p/lfpHcR3Fr0QBrhHufmp/zGEd5Fb+dj7Q1jQP
	 D2uQYpHHqLttw==
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5ead4026fe6so280910e0c.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:21:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxyTKQSEBQOsONlj45p4PnO5EKgAB4xaNahBdBzOd6qvzWtheKrPxCfc7vNks9jgIOZGLc9mkWWzQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8WOtvF8LvUmagdUvGiu0Wv+YR/gAQ4FLnknKNaT4bGqy9D+dfA
	XPWqM2LWLQ6g5983ohci7bAtjVCjqAAJd14jbZG8VYsul/19F7sAWXAH4OG2KdAQYhqY93qUhSA
	OlPscAOpVguR6eKWH52RE9p/T/Msr1KA=
X-Received: by 2002:a05:6122:4201:b0:5ec:3e18:a8da with SMTP id
 71dfb90a1353d-5ecc441b1fcmr1433555e0c.17.1793978493365; Fri, 06 Nov 2026
 07:21:33 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793666444.git.daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <cover.1793666444.git.daniel.lezcano@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 6 Nov 2026 16:21:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gZg7YK3=3b1F=XkCCivLgdh8VsrcTPjtJ-OWD5xrPiLg@mail.gmail.com>
X-Gm-Features: AclHuK9CCZ7WvonglwGof9bjwwoUGS_sVdGWjdzjKqYplP9ZkfDSqeee2sQdvos
Message-ID: <CAJZ5v0gZg7YK3=3b1F=XkCCivLgdh8VsrcTPjtJ-OWD5xrPiLg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] powercap: Add generic hierarchy support and
 convert DTPM
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rafael@kernel.org, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>, 
	Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 5:48=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> Powercap controllers may expose trees of power zones, such as packages,
> clusters and CPUs. This series adds generic helpers to duplicate a static
> hierarchy description, create its zones through backend callbacks, and
> destroy them in reverse order. Parents must precede their children in the
> node array; the helpers validate that ordering rather than sorting nodes.
>
> Drivers supporting multiple platforms can place each platform's hierarchy
> description and node array in initdata. powercap_hierarchy_dup() creates =
a
> working copy of the selected hierarchy and rebases its parent pointers.
> All original descriptions, including those for unused platforms, can then
> be reclaimed automatically with init memory. Names and backend-private
> data are not duplicated and must remain valid for the working hierarchy.
>
> The controller supplies creation and destruction callbacks to connect the
> generic hierarchy traversal to its backend. The creation callback receive=
s
> the control type, node name, private data and parent zone, registers the
> zone with its operations and constraints, and returns it to the helper.
> The destruction callback unregisters it during rollback or teardown.
>
> The API supports both fatal creation errors, which roll back previously
> created zones, and optional nodes: a NULL callback result skips a node an=
d
> its descendants while allowing independent branches to be created.
>
> The helpers were motivated by the SPEL work and also let DTPM share the
> same hierarchy infrastructure:
> https://lore.kernel.org/lkml/20260702-qcom_spel_driver_upstream-v3-0-434d=
50f0c5b0@oss.qualcomm.com/
>
> A kselftest exercises static and duplicated hierarchies, skipped branches=
,
> reuse after partial destruction, and rejection of repeated creation. Its
> userspace script checks the 16 exported zones and selected attribute
> values, then removes the module with a sysfs attribute descriptor open.
>
> DTPM is converted to the generic helpers while preserving best-effort
> creation when individual backends are unavailable. The CPU backend finds
> an online sibling when a hierarchy's representative CPU is offline.
> Entirely offline policies remain unavailable during initialization.
>
> The RK3399 description is reduced to one CPU entry per cpufreq policy.
> The old backend already suppressed duplicate registration; the extra
> entries were redundant descriptions, not additional registered zones.
> Finally, a shared Rockchip virtual descriptor and an RK3588 CPU hierarchy
> are added. RK3588's three frequency domains are represented by cpu@0,
> cpu@400 and cpu@600 below a virtual package node; no GPU zone is added
> for RK3588 in this series.
>
> Changes in v5 (since v4):
> - Address Lukasz Luba's review of patch 4: reject a DTPM DT node with a
>   NULL path before calling of_find_node_by_path(). Treat the missing path
>   as an invalid descriptor (-EINVAL), rather than skipping it as an
>   unavailable backend.
> - Collect Reviewed-by tags from Lukasz Luba for patches 1, 3, 5 and 6.
> - Keep the v7.3 base and the six-patch organization.
>
> Changes in v4 (since v3):
> - Rebase on v7.3.
> - Address the selftest issues reported by Sashiko:
>   - Add a kselftest config fragment requesting CONFIG_POWERCAP,
>     CONFIG_MODULES and CONFIG_MODULE_UNLOAD, guard the module build with
>     CONFIG_POWERCAP, and skip building when prerequisites or Module.symve=
rs
>     are missing instead of failing at modpost.
>   - Resolve the kernel output directory and pass absolute O=3D,
>     KBUILD_OUTPUT and module-output paths to Kbuild so cleanup works when
>     a relative O=3D is inherited from the parent selftest make invocation=
.
>   - Keep the statically initialized mutex in permanent module data so its
>     lockdep key does not point into freed module init memory. Retain a
>     separate init-only description for the hierarchy duplication test.
>   - Return KSFT_SKIP when powercap sysfs support or the test module is
>     unavailable, while retaining failures for actual module-load errors.
>
> Changes in v3 (since v2):
> - Rebase on v7.3-rc7.
> - Add POWERCAP_HIERARCHY_INIT() and document static versus duplicated
>   hierarchy ownership and lock initialization.
> - Explain how duplication retains the selected platform hierarchy while
>   init memory containing the original descriptions is reclaimed, and
>   describe the controller callbacks and their arguments.
> - Reject populated hierarchies with -EBUSY before invoking callbacks.
> - Validate names and parent ordering before zone creation, including for
>   static hierarchies; document the accepted hierarchy structure.
> - Use explicit mutex locking, a signed reverse-loop index, and the cleare=
r
>   powercap_node.zone member name.
> - Define NULL creation results as skipped branches and retain rollback fo=
r
>   error pointers, preserving DTPM's best-effort behavior.
> - Handle offline CPU representatives through an online policy sibling
>   while holding the CPU hotplug read lock.
> - Fix selftest output-directory handling and module cleanup, use
>   powercap-owned zone allocations, and keep shell validation/counting in
>   the main shell so failures propagate.
> - Extend and document selftest coverage for static creation, skipped
>   branches, hierarchy reuse, -EBUSY, and an open descriptor at teardown.
> - Fix indentation, __initdata placement, unnamed setup callback arguments=
,
>   and whitespace-only lines reported by checkpatch and patch application.
> - Correct descriptions of redundant CPU entries and actual sysfs checks.
>
> Earlier generic hierarchy API and selftest submission:
> https://lore.kernel.org/all/20260806110159.69690-1-daniel.lezcano@oss.qua=
lcomm.com/
>
> Daniel Lezcano (6):
>   powercap: Add generic zone hierarchy creation helpers
>   selftests/powercap: Add powercap hierarchy creation API tests
>   powercap: dtpm: Remove duplicate RK3399 CPU hierarchy nodes
>   powercap: dtpm: Use generic powercap hierarchy helpers
>   powercap: dtpm: Rename Rockchip virtual node descriptor
>   powercap: dtpm: Add RK3588 hierarchy
>
>  drivers/powercap/dtpm.c                       | 180 +++++-----
>  drivers/powercap/dtpm_cpu.c                   |  62 +++-
>  drivers/powercap/dtpm_devfreq.c               |  22 +-
>  drivers/powercap/powercap_sys.c               | 204 ++++++++++++
>  drivers/soc/rockchip/dtpm.c                   | 129 +++++--
>  include/linux/dtpm.h                          |   6 +-
>  include/linux/powercap.h                      | 205 ++++++++++++
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/powercap/Kbuild       |   5 +
>  tools/testing/selftests/powercap/Makefile     |  46 +++
>  tools/testing/selftests/powercap/config       |   3 +
>  .../selftests/powercap/powercap_hierarchy.c   | 314 ++++++++++++++++++
>  .../selftests/powercap/powercap_hierarchy.sh  | 128 +++++++
>  13 files changed, 1153 insertions(+), 152 deletions(-)
>  create mode 100644 tools/testing/selftests/powercap/Kbuild
>  create mode 100644 tools/testing/selftests/powercap/Makefile
>  create mode 100644 tools/testing/selftests/powercap/config
>  create mode 100644 tools/testing/selftests/powercap/powercap_hierarchy.c
>  create mode 100755 tools/testing/selftests/powercap/powercap_hierarchy.s=
h
>
>
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> --

Since Likasz is happy with the first patch and the majority of the
others, and Sashiko doesn't complain either, please feel free to send
a pull request to me for 7.5 including this series when you consider
it as ready.

Thanks!
