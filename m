Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3375D310620;
	Fri, 29 May 2026 01:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019016; cv=none; b=Dg+vLBhyMBJDG94pZaRYMPCrcPo8L2elfg+n6KZ+m3wzRHnivkU1xJjegVZT5yUhIs+Hk6qgRdltUm1C7pnCMQ70sum3X451OexCpXfUq50QAJ4nLUYHnHA/FcDMI9aRemhQ815spYxhb9seKUjZZMNrYPZrNtcYEB/RGFjKqc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019016; c=relaxed/simple;
	bh=1AsmdiETNEFx3hBEl6SrqPw/3LZ6Ju9GvXYIAYkH7dw=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=YzADaHOTje7ZaVe38tOJd4DvxwOoG2kwFmbi6cKGpFM3hsHsZmKv+ROg/uSOw5J+x6vanpnPMX5GUdOsDAl7/vHvzNe6Cu1l3MNLn60VVe8bC4m2uC8i2EtJP5LbbzrBnpq4YySq6iFB2HTkFcvycyy0Q4OWUczSfqujVPB84ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKptxWx2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKptxWx2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00C61F000E9;
	Fri, 29 May 2026 01:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780019014;
	bh=e9PK2+v56bWHft/pJdttvPO2BAiTBE3dQNzkNxA8Mzw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date;
	b=hKptxWx2tQQZtStuLM0FIi1dSu3BqRbU1gQSwf4I+aFwL+iMlDMMITZPJtoC8HdN2
	 sgNPbt8XOyJrGqodW58H2UIKnufLtr+wo7EHpH7h9yT8/EIe5CnDONi9r1blRiAq0m
	 5oZN86fvEMJdRY9iZztkzoiwqpjB7UBlxAeE4Si6VX61f2yKzi6nKlt89xNx/LCJIg
	 npl+qaBgMUgSUzmb4Ef/v2b895my92jcqjRHszbXoexlIYimD7mgW5w5ngHlJar9x4
	 cgocL7hsIcDV+h9E2H7TsWzNN2MpVvhygFISzYbXHJRcPxgrhJzqJl4yNHZK/UlVIw
	 mlKoCXikGs3Mg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <07739437-4720-4a15-87cc-40f6f92f3759@kernel.org>
References: <20260511100805.121432-1-angelogioacchino.delregno@collabora.com> <20260511141743.251a47e4@jic23-huawei> <07739437-4720-4a15-87cc-40f6f92f3759@kernel.org>
Subject: Re: [PATCH RESEND v8 00/10] SPMI: Implement sub-devices and migrate drivers
From: Stephen Boyd <sboyd@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, sre@kernel.org, krzk@kernel.org, dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com, melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com, ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org, luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com, mitltlatltl@gmail.com, krishna.kurapati@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, kernel@collabora.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Date: Thu, 28 May 2026 18:43:33 -0700
Message-ID: <178001901320.7182.15120759905441640016@lazor>
User-Agent: alot/0.12

Quoting AngeloGioacchino Del Regno (2026-05-20 04:51:26)
> On 5/11/26 15:17, Jonathan Cameron wrote:
> > On Mon, 11 May 2026 12:07:55 +0200
> > AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wr=
ote:
> >=20
> > Hi Angelo,
> >=20
> > Why the resend?  If marking a series with that I expect to see it
> > called out as first thing in the cover letter.
> >=20
>=20
> Right, forgot to mention why.
>=20
> The v8 was sent on January 2026, I pinged maintainers to pick it on
> March 2026, even if this was fully reviewed by multiple people nobody
> picked anything here.
>=20
> ....and I've resent it because pinging multiple times didn't work, and
> because the series got old all that much. :-)
>=20

I take it you want me to apply these patches to the spmi tree? Can you
respond to the Sashiko bot comments about why it's wrong or fix issues
it found?
