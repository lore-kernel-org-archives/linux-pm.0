Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C72140961C
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761206; cv=none; b=s/bNjkZHTzd3NBSYAgXDQ/2zNz0mbE2IROY10pWWhCPkgA5jxAW2uQdW0OkR8dHhaJ/TMjmHJyKqUxZsFGqKCt/ZN1J4B0hahT6hhaczL6q8UmtmqEmmVHotkFDV0AKmRKhj+CA0NKgJXYcndcW7fjaxteGYvwP4/mMYXmuGZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761206; c=relaxed/simple;
	bh=rh1eLSVVlNLNo/CfcBH9x58GeH1IP8v1OBx+qCItK94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVUIiooOSPi43KX7FKmcs2be64xQdU2aNb/yNrqWlsqsN/J0L9p5Uwm0/3mml8VI+aQzH221TmoclDZ5WHN2Hy9guGLOONEVp4yJBjaV7+GVFV9I0nGzYZYu+nfjSF9EejR0hNdfGsR9v2bYE7lds2jwMqYU0PET4gWy8PNsqrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bQtZJW7x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f0VGDxTK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bQtZJW7x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f0VGDxTK"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673C4nn9856173
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 12:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rh1eLSVVlNLNo/CfcBH9x58GeH1IP8v1OBx+qCItK94=; b=bQtZJW7xURfw1K8P
	JbrKy4C7zNGt1oX0z9cL1YPZyNfKYOyvQ1Pt6zPn5e5nqoqMHPrzG6hgmDp+6x1L
	lswiM2dP5b9ZPLaW3lh0SNMKZqa+meLz+PBIBuxm9WrZiFPRfjadaJArQLDWszq+
	B09qqt68o2bupcFzO7iDHlj/YdhkUqk8lLzT65cZl//Jwz3NnNHjjijPojl050HD
	86SOyeE0v7OoKJMzHNs89R6z0C5qYmmd+Gzo74w1oAiUAoKnql8/RnY5+nAt7xcj
	aBZm2txyrKJP3uznCisBzRH1AemgWaqBkKvJ1lEkSG8ktBoASGCunmYba5IhAbUR
	i80e8A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrb9j0r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 12:46:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cacf17c7e0so40971555ad.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785761203; x=1786366003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rh1eLSVVlNLNo/CfcBH9x58GeH1IP8v1OBx+qCItK94=;
        b=f0VGDxTKM9PsOQbaxVt6OANoCTyQK25aRTYQZVMQihA5kT212YL4YwLS/jKP2TMcaj
         y4TD1pqZZBN9ljlJRFWXUe/kV25dlJ+GHGf62iV/vCF50fAeOFBYRsdlg6c/UJRTRDqu
         h1+2PoQ+b+egmpX+FAUCK/eBnMlAQZUaosMAhPxAVr3fVfO9+FpTz7SNQy32UdvmhazV
         iUBPNeZvxQWLoix2SlajcQRUIVON1WVVYcGbZzb4s7B0Z7P09VOR7JNs5OKxYipB6NrL
         UQRKFsF3uzizTku16OoveIdfEb1oZAH1FSydOjSvhmSOSYVsvLmRZ7byI1mYWZjNCUrX
         2AnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785761203; x=1786366003;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rh1eLSVVlNLNo/CfcBH9x58GeH1IP8v1OBx+qCItK94=;
        b=XehvqMVw+yEw9jM0XmzDE3JRvil4150yB3HmzXeezcLDo54gVcWEccsodROaCnbWLW
         5ngjJt7go/N9iFZXl8MmvzBnOOByD6HsTvJ3QuEIMLxqklkjS+2PCyNPDMgh44y+jdqF
         mgn/xi1WcASJrE9X+FU36Ca2J4g8/x5OtIkci8vmLroQjoMkMKne117GQ5tiSMsHpZ3H
         HwBIoTOAFeLRhmgmZ5tFOWVFWr5cdgnPCjIiqKa6up+jQeZlC06nmocppFw9Yo/0bwb/
         wTvO4aLqcLOsXp68pNypOXQv+unLB2yltHwfzaxH/6+N9GA86OROM0/qak0g1gFLDCyl
         Phyg==
X-Forwarded-Encrypted: i=1; AHgh+RrLL6mbTOhey7z4vhALyScsyZ34pLkk2rEgkhYsBrladwrYEi3LyZPUIKxXgRE2ru/GPp4Dsgh7+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxNqI48eXSlS/ksZnU6hz8WxWWE90JQuThBezk27CpNPqRfOmp
	VhRaY8vsze938Wp97pEr1Dn7lcWMBbE38viyrOnJm+uFtFhTWcm6AY5WWo+kgyBkS5FIszP06ji
	5xB1T4olNZWhkB4Rhl8HqAOfI0z5Al52Of61Jm1vL0/XSnXbJnRGPmhBvdLhMvQ==
X-Gm-Gg: AR+sD12vP8SVEcwKCYonoTXvQ+5NCthEZnjxugMrda+v3WqaSBLKmXa+mQISRqQckks
	AZaJafSxc8YksHJ9/C+Dqus50mcY1+Coi4T7cA7Ck07gMNEiqALkoRqbXyKGnj+VGeaRjlT+AXm
	Y7OHS8fcVPojmXxzC3Bws0KFfdOf5xRygLfmGNjEtHK8bhq7haD3OmuvdJNjbodflqEtAktVsez
	HF6xkwZVKwkDfIvlbeXcJ+Itdn8hR6Zm9LYUbmEOq7W2vupi1a3uXkVOPsosc0aLdZHf08FrLit
	P9WtzHFgrmfwoi3PsftsVD0SN9jybotUWW64dgTwsXBfyLdAwZboiXrmIxEpN86TkpMITBiBrBc
	OsyE3d3oMyewLDr2N/NW7a1z6gqWoMDtbag==
X-Received: by 2002:a17:903:37c8:b0:2b2:67ca:5ff9 with SMTP id d9443c01a7336-2d051efd46amr97307365ad.0.1785761203059;
        Mon, 03 Aug 2026 05:46:43 -0700 (PDT)
X-Received: by 2002:a17:903:37c8:b0:2b2:67ca:5ff9 with SMTP id d9443c01a7336-2d051efd46amr97307005ad.0.1785761202596;
        Mon, 03 Aug 2026 05:46:42 -0700 (PDT)
Received: from [10.218.44.82] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae193fasm37538085ad.7.2026.08.03.05.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 05:46:42 -0700 (PDT)
Message-ID: <14c7d776-a1e5-41a6-aa47-a9ff16516c81@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 18:16:30 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 05/12] dt-bindings: arm: Document reboot mode magic
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio
 <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>, Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sre@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Christian Loehle <christian.loehle@arm.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        devicetree@vger.kernel.org, Andre Draszik <andre.draszik@linaro.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        John Stultz <john.stultz@linaro.org>, mfd@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Moritz Fischer <moritz.fischer@ettus.com>
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
 <20260803-arm-psci-system_reset2-vendor-reboots-v24-5-889281373870@oss.qualcomm.com>
 <178575749351.2483197.6720070407824857023.robh@kernel.org>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <178575749351.2483197.6720070407824857023.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExNCBTYWx0ZWRfX6GUKCuGLKAJ8
 bwTzc/WmmsM14YcKj9SW2xtfUgaPix7j3s7K2fePqXExik3iujwTwDt1tLyymxSsH6TmtGa9Ed/
 kdxBe0OP9IaDI1AxvzMVV9u9Ts21gb4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExNCBTYWx0ZWRfX36APNJNiejsY
 vDiA23IH6Wt7Z8KwTmEPMY2ryqPeNxDLbKqRijgN8wLtfE14lZg5vIiFqYXLl3y+ybLdpPODp5S
 3Eh17dPKvJjbQj2tyxWsEXaMIeijxwazZ5OxWW3ISr6VMTGaaKYASBlynr3Z+L15qKevZul/+ge
 THd5ly60gp+PtHOJb+znpP1srAx9j0iyDaBnNGoKQiMio3agDpEp2HGWvKCsrVfnQnsKuqBXtdj
 n7LybK/N72QIarPRzSA5TnFMwgci+HFN05GpCZ4/Y61mWQesRmbVLH+kmmgdpMTfRBYEilB8tLS
 eIZxGxVsjwx3cgElTLJzsCl1RITk90y+t5uGuMwWwXNQ7ypOf2FH0L4wDtnY17BRsgmpXy+bmat
 h6YGtBZut4fneR7aq/Jm6LjcglJFSHzSkh5G9GSX6BWcwCm62vTyjBbgXcsNl+bn5Y8yHQODhxi
 b8Lx+XI50izSonP7+Zg==
X-Authority-Analysis: v=2.4 cv=RNSD2Yi+ c=1 sm=1 tr=0 ts=6a708db4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0awkmHLjsCMGZ7zvgVIA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: N4AZGSHuWJ3G9rGYSpCq-PeCZtvfuHvX
X-Proofpoint-ORIG-GUID: N4AZGSHuWJ3G9rGYSpCq-PeCZtvfuHvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030114

DQoNCk9uIDgvMy8yMDI2IDU6MTQgUE0sIFJvYiBIZXJyaW5nIChBcm0pIHdyb3RlOg0KPiAN
Cj4gT24gTW9uLCAwMyBBdWcgMjAyNiAxNToxMzozNiArMDUzMCwgU2hpdmVuZHJhIFByYXRh
cCB3cm90ZToNCj4+IEFkZCBiaW5kaW5ncyB0byBkZXNjcmliZSB2ZW5kb3Itc3BlY2lmaWMg
cmVib290IG1vZGVzLiBWYWx1ZXMgaGVyZQ0KPj4gY29ycmVzcG9uZCB0byB2YWxpZCBwYXJh
bWV0ZXJzIHRvIHZlbmRvci1zcGVjaWZpYyByZXNldCB0eXBlcyBpbiBQU0NJDQo+PiBTWVNU
RU1fUkVTRVQyIGNhbGwuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogU2hpdmVuZHJhIFByYXRh
cCA8c2hpdmVuZHJhLnByYXRhcEBvc3MucXVhbGNvbW0uY29tPg0KPj4gLS0tDQo+PiAgIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vcHNjaS55YW1sIHwgNTggKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNTggaW5zZXJ0
aW9ucygrKQ0KPj4NCj4gDQo+IE15IGJvdCBmb3VuZCBlcnJvcnMgcnVubmluZyAnbWFrZSBk
dF9iaW5kaW5nX2NoZWNrJyBvbiB5b3VyIHBhdGNoOg0KPiANCj4geWFtbGxpbnQgd2Fybmlu
Z3MvZXJyb3JzOg0KPiANCj4gZHRzY2hlbWEvZHRjIHdhcm5pbmdzL2Vycm9yczoNCj4gL2J1
aWxkcy9yb2JoZXJyaW5nL2R0LXJldmlldy1jaS9saW51eC9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvYXJtL3BzY2kueWFtbDogcHJvcGVydGllczpyZWJvb3QtbW9kZTpw
YXR0ZXJuUHJvcGVydGllczpebW9kZS0uKiQ6IHsnbWluSXRlbXMnOiAxLCAnbWF4SXRlbXMn
OiAzLCAnaXRlbXMnOiBbeydkZXNjcmlwdGlvbic6ICdhcmcxICh2ZW5kb3Itc3BlY2lmaWMg
U1lTVEVNX1JFU0VUMiByZXNldF90eXBlKScsICdhbGxPZic6IFt7JyRyZWYnOiAnL3NjaGVt
YXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyJ30sIHsnbWluaW11bSc6IDIxNDc0
ODM2NDh9XX0sIHsnZGVzY3JpcHRpb24nOiAnYXJnMiAoY29va2llX2xvIGluIDItY2VsbCBm
b3JtLCBjb29raWVfaGkgaW4gMy1jZWxsIGZvcm0pJywgJyRyZWYnOiAnL3NjaGVtYXMvdHlw
ZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyJ30sIHsnZGVzY3JpcHRpb24nOiAnYXJnMyAo
Y29va2llX2xvIGluIDMtY2VsbCBmb3JtKScsICckcmVmJzogJy9zY2hlbWFzL3R5cGVzLnlh
bWwjL2RlZmluaXRpb25zL3VpbnQzMid9XSwgJ2Rlc2NyaXB0aW9uJzogJ0Rlc2NyaWJlcyBh
IFBTQ0kgU1lTVEVNX1JFU0VUMiB2ZW5kb3Itc3BlY2lmaWMgcmVzZXQgdHlwZS4gVGhlIHN0
cmluZ1xuYWZ0ZXIgIm1vZGUtIiBtYXBzIGEgcmVib290IG1vZGUgdG8gYSB2ZW5kb3Itc3Bl
Y2lmaWMgcmVzZXQuXG5BIHZlbmRvci1zcGVjaWZpYyByZXNldCB0YWtlcyB0d28gYXJndW1l
bnRzLCBhIDMyLWJpdCByZXNldF90eXBlIGFuZCBhXG42NC1iaXQgY29va2llLiBUaGUgYXJn
dW1lbnRzIGFyZSBlbmNvZGVkIGFzIHVwIHRvIHRocmVlIDMyLWJpdCBjZWxscy5cbkVhY2gg
bW9kZSBwcm9wZXJ0eSBpcyBlbmNvZGVkIGFzIG1vZGUteHh4ID0gPGFyZzFbLCBhcmcyWywg
YXJnM11dPixcbndoZXJlOlxuLSBhcmcxIGlzIHJlc2V0X3R5cGUgYW5kIG11c3QgYmUgPj0g
MHg4MDAwMDAwMC5cbi0gSW4gMi1jZWwNCj4gICBsIGZvcm0sIGFyZzIgaXMgbG93ZXIgMzIg
Yml0cyBvZiBjb29raWUuXG4tIEluIDMtY2VsbCBmb3JtLCBhcmcyIGlzIGhpZ2ggMzIgYml0
cyBvZiBjb29raWVcbiAgYW5kIGFyZzMgaXMgbG93IDMyIGJpdHMgb2YgY29va2llLlxuXG5B
bGwgdmFsdWVzIHNob3VsZCBiZSBwcm92aWRlZCBhcyBwZXIgdGhlIFBTQ0kgU1lTVEVNX1JF
U0VUMlxuc3BlY2lmaWNhdGlvbi5cbid9IHNob3VsZCBub3QgYmUgdmFsaWQgdW5kZXIgeydy
ZXF1aXJlZCc6IFsnbWF4SXRlbXMnXX0NCj4gCWhpbnQ6ICJtYXhJdGVtcyIgaXMgbm90IG5l
ZWRlZCB3aXRoIGFuICJpdGVtcyIgbGlzdA0KPiAJZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8v
ZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2l0ZW1zLnlhbWwNCj4gDQo+IGRvYyByZWZl
cmVuY2UgZXJyb3JzIChtYWtlIHJlZmNoZWNrZG9jcyk6DQo+IA0KPiBTZWUgaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2RldmljZXRyZWUvcGF0Y2gvMjAyNjA4MDMt
YXJtLXBzY2ktc3lzdGVtX3Jlc2V0Mi12ZW5kb3ItcmVib290cy12MjQtNS04ODkyODEzNzM4
NzBAb3NzLnF1YWxjb21tLmNvbQ0KPiANCj4gVGhlIGJhc2UgZm9yIHRoZSBzZXJpZXMgaXMg
Z2VuZXJhbGx5IHRoZSBsYXRlc3QgcmMxLiBBIGRpZmZlcmVudCBkZXBlbmRlbmN5DQo+IHNo
b3VsZCBiZSBub3RlZCBpbiAqdGhpcyogcGF0Y2guDQo+IA0KPiBJZiB5b3UgYWxyZWFkeSBy
YW4gJ21ha2UgZHRfYmluZGluZ19jaGVjaycgYW5kIGRpZG4ndCBzZWUgdGhlIGFib3ZlDQo+
IGVycm9yKHMpLCB0aGVuIG1ha2Ugc3VyZSAneWFtbGxpbnQnIGlzIGluc3RhbGxlZCBhbmQg
ZHQtc2NoZW1hIGlzIHVwIHRvDQo+IGRhdGU6DQo+IA0KPiBwaXAzIGluc3RhbGwgZHRzY2hl
bWEgLS11cGdyYWRlDQo+IA0KPiBQbGVhc2UgY2hlY2sgYW5kIHJlLXN1Ym1pdCBhZnRlciBy
dW5uaW5nIHRoZSBhYm92ZSBjb21tYW5kIHlvdXJzZWxmLiBOb3RlDQo+IHRoYXQgRFRfU0NI
RU1BX0ZJTEVTIGNhbiBiZSBzZXQgdG8geW91ciBzY2hlbWEgZmlsZSB0byBzcGVlZCB1cCBj
aGVja2luZw0KPiB5b3VyIHNjaGVtYS4gSG93ZXZlciwgaXQgbXVzdCBiZSB1bnNldCB0byB0
ZXN0IGFsbCBleGFtcGxlcyB3aXRoIHlvdXIgc2NoZW1hLg0KPiANCg0KdGhhbmtzIHdpbGwg
Y2hlY2sgYW5kIHVwZGF0ZSB0aGlzIHBhdGNoLg0KDQp0aGFua3MsDQpTaGl2ZW5kcmENCg==

