Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C5133FE36
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773415922; cv=none; b=Xtag1edURCDZ8Wl2e6V9tt0Jc9U/0R1ebEwDsyos9wRXMi//3bU/Eh4rll/Gr4PP8vh3JSqlKuM5aIoya5oglhEgF7e0xkgTfl3N0/ktwysJkgLsPA07Wz4b9RgME+TLfhVyDajVuJAvGf3nFN1pVH3Kx0tbOJLEAN6JOGp0Cyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773415922; c=relaxed/simple;
	bh=xlK7fd03Zsa9My6o4ZFqIg+tnyfO3jn1IV6L/SZmr9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TeT13wY0LFOpqo+l6R5eCHuFtqm6GsU1Qgfg+fuq5mBwc7YoY0JlhZnePV4KHR7meoCRA8dLWPB7QaVfBfnB92MwKLfMtQnPc3OXRt3YyO7geTv9VitdSR84Ix00/zoTr1eCwdH1iUVmMVTlXkVfstRneXfhQ8ArGdS+ZYcOaeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGAhUS9e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGAhUS9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D193C2BC86
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773415922;
	bh=xlK7fd03Zsa9My6o4ZFqIg+tnyfO3jn1IV6L/SZmr9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZGAhUS9eLTjSsuQmzGIK7oifIVnfaL5P2NBDpst1wSR3f6aXoMcL7WbeFVj5lUMp6
	 QHOJQX7O3PYvWdMp2R8bFZSlfHfQQthdpvUaQxRy/cwvzQtv+hpvxeKxHzu59+5dLu
	 W4clHgX/9zrhWErt5FuX9V9OkKBGa0JOj8r3Nu6UnTCTAr6VG5XKbfbhk8DwwagQEv
	 Rn6qF2RiOk5gslZ2kW+yNwYgTzczBvh9LC5Mp03hr4TJQlqa3JRfHme/6+XygFesut
	 2/QDPE36In2sNnNIZNfXqPXWqryKNDmDTMY4Valx2TcDoxDbCnlcslCoxjtm7f8er2
	 g4zlaKTcK+bGw==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d7653db148so1667073a34.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 08:32:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnWhXebQclpsY3zvK/7gseKqzrcBCWj0rmTcjr2ZssESLltrOygD1ejkS5TgzF93uLk4834NP8NA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcFqC6KudBsIb61eSGY1VTgKEidJCcSd5L22esMRz2RQ52IgLg
	1Y2Rwm80ewYafY1dlRn/5pH/SmTVlGtIo4kxN8x816qC6xqNnbvqUthvIt1HlJlMGxOY6RqokPt
	NcU7cMioRjDGcbTx0z8mVXHdgYfmh9+c=
X-Received: by 2002:a05:6820:4deb:b0:67b:c8c4:43bd with SMTP id
 006d021491bc7-67bdaa96769mr2165571eaf.72.1773415920704; Fri, 13 Mar 2026
 08:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225084930.1692228-1-pierre.gondois@arm.com>
 <20260225084930.1692228-3-pierre.gondois@arm.com> <CAJZ5v0iLEBiQE8GEyBn_RFHyojQOyrf=jr_CbPdG6dyvoqXBiA@mail.gmail.com>
 <CAJZ5v0hH7jGoJdFrdh81woh_GVk3WYAeB+OM7nbu0jy0O1j47w@mail.gmail.com> <b740cefd-cbfa-4b98-b3ee-8fefdaf8e322@arm.com>
In-Reply-To: <b740cefd-cbfa-4b98-b3ee-8fefdaf8e322@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Mar 2026 16:31:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jE0-tP5hz8yMrxriawYJ3pQyQs8rYMn_TA5fm1umb84w@mail.gmail.com>
X-Gm-Features: AaiRm51m5v_zpkiVtKSyeYd4XAJIzHz5LYg7-tef_IoUfKs-F6_B0CQ6rrmSqsw
Message-ID: <CAJZ5v0jE0-tP5hz8yMrxriawYJ3pQyQs8rYMn_TA5fm1umb84w@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] cpufreq: Add boost_freq_req QoS request
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>, 
	Christian Loehle <christian.loehle@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 3:30=E2=80=AFPM Pierre Gondois <pierre.gondois@arm.=
com> wrote:
>
>
> On 3/11/26 14:57, Rafael J. Wysocki wrote:
> > On Wed, Mar 11, 2026 at 2:52=E2=80=AFPM Rafael J. Wysocki<rafael@kernel=
.org> wrote:
> >> On Wed, Feb 25, 2026 at 9:49=E2=80=AFAM Pierre Gondois<pierre.gondois@=
arm.com> wrote:
> >>> The Power Management Quality of Service (PM QoS) allows to
> >>> aggregate constraints from multiple entities. It is currently
> >>> used to manage the min/max frequency of a given policy.
> >>>
> >>> Frequency constraints can come for instance from:
> >>> - Thermal framework: acpi_thermal_cpufreq_init()
> >>> - Firmware: _PPC objects: acpi_processor_ppc_init()
> >>> - User: by setting policyX/scaling_[min|max]_freq
> >>> The minimum of the max frequency constraints is used to compute
> >>> the resulting maximum allowed frequency.
> >>>
> >>> When enabling boost frequencies, the same frequency request object
> >>> (policy->max_freq_req) as to handle requests from users is used.
> >>> As a result, when setting:
> >>> - scaling_max_freq
> >>> - boost
> >>> The last sysfs file used overwrites the request from the other
> >>> sysfs file.
> >>>
> >>> To avoid this, create a per-policy boost_freq_req to save the boost
> >>> constraints instead of overwriting the last scaling_max_freq
> >>> constraint.
> >>>
> >>> Signed-off-by: Pierre Gondois<pierre.gondois@arm.com>
> >>> ---
> >>>   drivers/cpufreq/cpufreq.c | 37 ++++++++++++++++++++++++++++++++----=
-
> >>>   include/linux/cpufreq.h   |  1 +
> >>>   2 files changed, 33 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >>> index db414c052658b..50467b938668a 100644
> >>> --- a/drivers/cpufreq/cpufreq.c
> >>> +++ b/drivers/cpufreq/cpufreq.c
> >>> @@ -1359,17 +1359,21 @@ static void cpufreq_policy_free(struct cpufre=
q_policy *policy)
> >>>          /* Cancel any pending policy->update work before freeing the=
 policy. */
> >>>          cancel_work_sync(&policy->update);
> >>>
> >>> -       if (policy->max_freq_req) {
> >>> +       if ((policy->max_freq_req && !policy->boost_supported) ||
> >>> +           policy->boost_freq_req) {
> >> Are you sure?
> >>
> >>>                  /*
> >>> -                * Remove max_freq_req after sending CPUFREQ_REMOVE_P=
OLICY
> >>> -                * notification, since CPUFREQ_CREATE_POLICY notifica=
tion was
> >>> -                * sent after adding max_freq_req earlier.
> >>> +                * Remove max/boost _freq_req after sending CPUFREQ_R=
EMOVE_POLICY
> >>> +                * notification, since CPUFREQ_CREATE_POLICY notifica=
tion was sent
> >>> +                * after adding max/boost _freq_req earlier.
> >>>                   */
> >>>                  blocking_notifier_call_chain(&cpufreq_policy_notifie=
r_list,
> >>>                                               CPUFREQ_REMOVE_POLICY, =
policy);
> >>> -               freq_qos_remove_request(policy->max_freq_req);
> >>>          }
> >>>
> >>> +       freq_qos_remove_request(policy->boost_freq_req);
> >>> +       kfree(policy->boost_freq_req);
> >>> +
> >>> +       freq_qos_remove_request(policy->max_freq_req);
> >>>          freq_qos_remove_request(policy->min_freq_req);
> >>>          kfree(policy->min_freq_req);
> >>>
> >>> @@ -1479,6 +1483,29 @@ static int cpufreq_policy_online(struct cpufre=
q_policy *policy,
> >>>                          goto out_destroy_policy;
> >>>                  }
> >>>
> >>> +               if (policy->boost_supported) {
> >>> +                       policy->boost_freq_req =3D kzalloc(sizeof(*po=
licy->boost_freq_req),
> >>> +                                                        GFP_KERNEL);
> >> Instead of doing this, why don't you add 1 to the policy->min_freq_req
> >> allocation size when boost is supported?  You'll destroy the policy if
> >> the allocation fails anyway.
>
>
> Yes right,
> this would make the error handling much simpler to follow.
>
> On the other hand Viresh seems to have acknowledged the logic,

But he has also said "+1" to this one. :-)

> so whatever seems is better to both of you.

I think we agree.
