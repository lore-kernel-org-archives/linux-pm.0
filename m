Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B7466B44;
	Thu,  4 Jun 2026 12:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576435; cv=none; b=EwNp0q6dLB0GKkwY4lG4Fg9iZNNO3NX3MY3KvqWETCAaS/Cb9ivLoSOZJ33Dy1eauFOxMtXNelrzom9svn5r6tesY2+hP7Gq8bZ8I2HrPCmfY1V76SPNWTrJEcNGi2IdJywnJ2NXjaXUOrAoKGbuBALX2NtGjO5l0GQGtjVJPDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576435; c=relaxed/simple;
	bh=OJ3Uqeo1IwOJW6q6880uQtHS9eNIQRcj3ScJXz4WdBA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RuEzXcTOLEw04K+0LjwtnN34nkgfb9HoPnnDQVh5g9rzJ+hUGXGZeb30k9MMCd/vHxMHY9rprCbXTNrOdQx6rR97+f/a4PJFvIVbYy6x0JVzCBdC8c0hVSL0CRTN7qKQdZi4f2Obt/pCGK5NMYaK3I6otHGkCiuHnHLAAYPb3dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=paFWhExG; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=+M4nbtGk; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="paFWhExG";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="+M4nbtGk"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1780576420; bh=kU+i7g8pqOTCGjUW+H8X7o/
	tBXoM+LzHFNQrdKZ87oQ=; b=paFWhExG6MmKynuibQT97ubMi6MiMrQApDPN/SYJcqYXKGlc/c
	MKfUx0k+JTNU6L6Yub0lHAJNZMwCjVurPvmcLsNMmhp/b9oHKfJJJdxG2o/JyaI7kdhqeioTrXn
	AZR52fWixg1iCgx8cAyoXFtj4EC6zth5ZTyCYFLn9xNp+xgxbp8g0uPWKogIhG07Rr+fPqakB7q
	W87v0e7XSyYmTT3OD+TktXMw6NuhJ3igCFIIAxtCDBDr6KVN2C8iKNbi4FvZyJRrIldIbBLfHTD
	RU9y3ekoO7XlCppdeD+PffOX/vf7M1tLz/CWC6Ado7uGJsqWtKhXc6LH7vw0UfMPXVw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1780576420; bh=kU+i7g8pqOTCGjUW+H8X7o/
	tBXoM+LzHFNQrdKZ87oQ=; b=+M4nbtGke1FBzzH6cDhb7MIhnGK7ozUuqUnPCrz874rXusc+Ni
	CKwO2yRl6XjT8tVdHa4Kv5cuumyS5YyRp7Bg==;
Date: Thu, 04 Jun 2026 14:33:37 +0200
From: =?ISO-8859-1?Q?Barnab=E1s_Cz=E9m=E1n?= <barnabas.czeman@mainlining.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stephan Gerhold <stephan@gerhold.net>
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/7=5D_remoteproc=3A_qcom=5Fq6v5?=
 =?US-ASCII?Q?=5Fmss=3A_Use_mss_as_regulator_for_MSM8953?=
User-Agent: Thunderbird for Android
In-Reply-To: <35e8f654-214d-4e8b-843f-87fa8cc1a782@oss.qualcomm.com>
References: <20260327-sdm632-rpmpd-v1-0-6098dc997d66@mainlining.org> <20260327-sdm632-rpmpd-v1-3-6098dc997d66@mainlining.org> <35e8f654-214d-4e8b-843f-87fa8cc1a782@oss.qualcomm.com>
Message-ID: <C5AF7872-093B-4039-9F3A-72BF855BB3D1@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 16 April 2026 15:32:25 CEST, Konrad Dybcio <konrad=2Edybcio@oss=2Equalc=
omm=2Ecom> wrote:
>On 3/27/26 9:11 PM, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wrote:
>> MSM8953 MSS is using mss-supply as regulator what is usually pm8953_s1=
=2E
>>=20
>> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas=2Eczeman@mainli=
ning=2Eorg>
>> ---
>>  drivers/remoteproc/qcom_q6v5_mss=2Ec | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/remoteproc/qcom_q6v5_mss=2Ec b/drivers/remoteproc/=
qcom_q6v5_mss=2Ec
>> index 4e9eb5bd11fa=2E=2E86edd826ede8 100644
>> --- a/drivers/remoteproc/qcom_q6v5_mss=2Ec
>> +++ b/drivers/remoteproc/qcom_q6v5_mss=2Ec
>> @@ -2705,6 +2705,14 @@ static const struct rproc_hexagon_res msm8953_ms=
s =3D {
>>  		},
>>  		{}
>>  	},
>> +	=2Eactive_supply =3D (struct qcom_mss_reg_res[]) {
>> +		{
>> +			=2Esupply =3D "mss",
>> +			=2EuV =3D 1050000,
>> +			=2EuA =3D 100000,
>
>I don't know if it's a typo, but msm8953-regulator=2Edtsi on msm-3=2E18
>suggests one more zero
I do not see any load values there only init-voltage what have six zeros=
=2E
>
>Konrad
