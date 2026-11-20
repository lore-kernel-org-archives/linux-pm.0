Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190309;
	b=w6ReFuXCnwzw1h4kRUGujdgLvGlZ2lHX4QP68hYfQeniqn67tLjhrzF/JXhEW/lD9FGu
	 n8z3mOIhSiqjMl3/IBjXFe78J1RCBoXM2md59eTdkPAwH6jGejH+u7h2mEH+fZZHppZ+n
	 2C+NLjrHGg9uDqz6Aa6gb3+eNqjmjb8s0lYv7kYJUTFbVgZ6lB1ru5Aoo6w5EP9TZ0Bhd
	 TDsDCrANH+vNXdXf0PBhPDg7IxWtRzTneezOtqw9JuTNgNeqZj5WaL1NVZGp5Diwe7kL+
	 eqfecKNKdQ2Duj99FA1DQeyZazWusB0sIdK2n0Vsua6tUXlZBV6sw7sa0P/y7OB9OcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190309;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UGn2Xr8Ly1HQXZSbSFJcSWI6kH+PUQItBE9t+lSvk3A=;
	b=161Uk/G5vyfFW9lv9+1nLq1m4Rzf46jFuVkHsvyuC/tFNYSlEcuVZtu+jwB+vqm9Bbnk
	 zo7zWLu6sbzMPMMT0vDgnfTIN9htUwivu5GMzxSBGx+0m4x6+c5Oh2oCz+thFYveu1xB6
	 VdMdhmBYaGZjrRK7jmxcUfbzCLcXFzL512KoAv08NYAR1SJXEsra0UJfqPtgRi7e3CaYi
	 tnTa4GdZARK78ErK5vUXTqC4Gfw1Y8Hd5hktaw8RYuGAOZIdSUdxR1zrt4xSMH4bSS3DB
	 eZzZ5Kon4ud2gS1iSrkRyLkLSAYbuYUwA0QEt8JC4uEgftkGKoLqi44WUGdhofFY86w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZKs2toD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1289606A325
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZKs2toD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097681F00A36
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 15:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795190309;
	bh=UGn2Xr8Ly1HQXZSbSFJcSWI6kH+PUQItBE9t+lSvk3A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cZKs2toD1/1OUcG/OPNE6FqHCbeQFMPDMQmFS1L6pO/rOhbBkwxVxEWLtzv2Ot3sY
	 4l42Weji6q2kFfJuYdn7D8O0JgnQw+nIDTWx9+Rae/MGyOmfnwNs9j4QUDR6L/MU0M
	 2V4mA3jT2TACiTybE33y/oZ7170T3ofWrPd/LgIUwiY8nfdKGgUkqr1P/vsYa986f9
	 KTbR1uV9O6TmhMQL8ExkhBKyU7TduaQTVJvQcnLXDqAsTNQ6k7kuz+gMd3LolCkE7/
	 gYz2iuucDHb7Ljj0+uIoOF7zq35/2Gih+8MPgU7cU6Kcauf+2dS+q0f/Yt3UjPkchR
	 4pbyEXzIQNk9A==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3ab3b29a298so8350731fa.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 07:58:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFyz6+AlAlh97ECl6WmjJg8BlNNbaH3Up8A6FDM7iRZHrtg+/M+U2ImHEmouYi37Fra1HXppHuXOw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Q65nstOWGH1IpOlSUBW2dzZ3YxF9zzh0hlv3LM6tvW2qQ5V7e
	tXYxe6XZEmrFbCcJU5REHUE61qvZNIckQ3CfyuCzYabUu7i5gWsFpF0w/nfHR5LjCc62Y2TNn7+
	a0lmwGv1uguMOQhh0ddL+Hsv2iTqDChk=
X-Received: by 2002:a05:651c:418c:b0:3a9:7f37:9bbc with SMTP id
 38308e7fff4ca-3ae7f9f3fcfmr9765561fa.11.1795190307450; Fri, 20 Nov 2026
 07:58:27 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103124336.174919-1-daiyanlong@kylinos.cn> <20261103124336.174919-2-daiyanlong@kylinos.cn>
In-Reply-To: <20261103124336.174919-2-daiyanlong@kylinos.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 16:58:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iV4Le4PXLrCC13rzqFM_2=NRyZTwgu1wBZC58Q5G7ANA@mail.gmail.com>
X-Gm-Features: Aa3M54qjT76rAPYzpTB3L78PLC6FJZuEgSB2yRHdvTEKaUyPsh29mykNrakzloY
Message-ID: <CAJZ5v0iV4Le4PXLrCC13rzqFM_2=NRyZTwgu1wBZC58Q5G7ANA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/thermal/thermometer: Fix missing NULL check
 after realloc()
To: YanLong Dai <daiyanlong@kylinos.cn>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 1:43=E2=80=AFPM YanLong Dai <daiyanlong@kylinos.cn> =
wrote:
>
> In configuration_init(), the return value of realloc() is assigned
> directly to config->tz_regex without checking for NULL. If realloc()
> fails, the original pointer is lost (memory leak) and subsequent
> dereference causes a NULL pointer crash.
>
> Fix by using a temporary variable to receive the realloc() result and
> checking for NULL before assigning to config->tz_regex.
>
> Fixes: 110acbc6a451 ("tools/thermal: Add a temperature capture tool")
> Signed-off-by: YanLong Dai <daiyanlong@kylinos.cn>
> ---
>  tools/thermal/thermometer/thermometer.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/tools/thermal/thermometer/thermometer.c b/tools/thermal/ther=
mometer/thermometer.c
> index b4f26d49e4c7..cc84540f467a 100644
> --- a/tools/thermal/thermometer/thermometer.c
> +++ b/tools/thermal/thermometer/thermometer.c
> @@ -142,6 +142,7 @@ static int configuration_init(const char *path, struc=
t configuration *config)
>         INFO("Found %d thermal zone(s) regular expression\n", length);
>
>         for (i =3D 0; i < length; i++) {
> +               struct tz_regex *tmp;
>
>                 config_setting_t *node;
>                 const char *name;
> @@ -163,8 +164,13 @@ static int configuration_init(const char *path, stru=
ct configuration *config)
>                         return -1;
>                 }
>
> -               config->tz_regex =3D realloc(config->tz_regex, sizeof(*co=
nfig->tz_regex) *
> -                                       (config->nr_tz_regex + 1));
> +               tmp =3D realloc(config->tz_regex, sizeof(*config->tz_rege=
x) *
> +                             (config->nr_tz_regex + 1));
> +               if (!tmp) {
> +                       ERROR("Failed to allocate memory for thermal zone=
 regex\n");
> +                       return -1;
> +               }
> +               config->tz_regex =3D tmp;
>
>                 if (regcomp(&config->tz_regex[config->nr_tz_regex].regex,=
 name,
>                             REG_NOSUB | REG_EXTENDED)) {
> --

Applied as 7.5 material along with the [2/2], thanks!
