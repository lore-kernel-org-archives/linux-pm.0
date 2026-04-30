Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF0477983;
	Thu, 30 Apr 2026 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777570002; cv=none; b=im+Xyb0eFGABoRXGnhJWNyTXMRIrQAj8/kY6Qh8uYEqa0qHwRkzwK1gctHIUhIcQguOPERMuYJ2xf7KrEhaXkvfXWR5P7tItjZSnvh6yKKExccx3LSTRsU7DY5NtY9rJ6JcsoSJjTsWN3HLrxSsdf6aoROSIfKcIRkq4qfI5mcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777570002; c=relaxed/simple;
	bh=jL+gANFznSru+9CcfAGa9hjDPDdwv96mRKeWD/jUees=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BZbUJosR63yyvtlU8anhZyRvYLuY0ZRqpekmFc337prIp6Cm1+BIYNVgFbEl7S461DG3tIOH2Cd7o0q5wSzLQ8b+gpP54yi01LUEJHaySBucM2oIbE+7kOfAMOe7vr3j+Rsk1P5WpMt/wWykKP/mIvk2IKnT8TvZT8TWtSo9xxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iasLoaeI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iasLoaeI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777570000; x=1809106000;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jL+gANFznSru+9CcfAGa9hjDPDdwv96mRKeWD/jUees=;
  b=iasLoaeIPVD59jJ/EMBVtcKC0dCjcZoThOmq4uGgt6m6SWsyDmKMzvJ9
   YPfoSI6YBvaOZY6g3VXZsjtdXTKuG+L57iEXrurIU1d/sGRw7twZarAyl
   5oHA9QLSzPcM2eXv35iLHtsPvOqXq2qxGhpVtPoHWNwBbZEaU1MQSYrgM
   YygVpf3DJL463/Wq1KndIRM+KIn4dSEb9+ujpphxtDTPBmCCkTE3+Elx/
   9a4TxE8+gHXPM2OdFAx58Tqf4KcPvm5fsvu6FS1vF1j2NilaiCd+N4zID
   PS4rg5386PeCoT/DL36LA9ZjOKifSqkPe95fLctDG1O9mA8X30Wn9T+vM
   g==;
X-CSE-ConnectionGUID: U/irvPLOTXWYyxDLm41yCg==
X-CSE-MsgGUID: 1ONnKESiSx+hzwFiF0AnfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="88845115"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="88845115"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 10:26:40 -0700
X-CSE-ConnectionGUID: MUpxuDowRWyv8g7YXm0L1g==
X-CSE-MsgGUID: DH8LMrc9Snu8MLSu9OYq9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="239638951"
Received: from lstrano-mobl6.amr.corp.intel.com ([10.124.222.88])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 10:26:39 -0700
Message-ID: <31cae88810593e091de28809a220ba31a67ee0bd.camel@linux.intel.com>
Subject: Re: [PATCH] PM: tools: fix ValueError when parsing incomplete
 device properties
From: Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To: Gongwei Li <13875017792@163.com>, "Wysocki, Rafael J"
	 <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Gongwei Li
	 <ligongwei@kylinos.cn>
Date: Thu, 30 Apr 2026 10:26:39 -0700
In-Reply-To: <20260424071208.3610628-1-13875017792@163.com>
References: <20260424071208.3610628-1-13875017792@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI2LTA0LTI0IGF0IDE1OjEyICswODAwLCBHb25nd2VpIExpIHdyb3RlOgo+IEZy
b206IEdvbmd3ZWkgTGkgPGxpZ29uZ3dlaUBreWxpbm9zLmNuPgo+IAo+IFdoZW4gcGFyc2luZyBk
ZXZpY2UgcHJvcGVydGllcyBmcm9tIGZ0cmFjZSBkYXRhLCB0aGUgZGV2cHJvcHMoKQo+IGZ1bmN0
aW9uCj4gYXNzdW1lcyB0aGF0IGVhY2ggbGluZSBoYXMgYXQgbGVhc3QgdGhyZWUgZmllbGRzIGFu
ZCB0aGF0IHRoZSB0aGlyZAo+IGZpZWxkCj4gKGZbMl0pIGFsd2F5cyBjb250YWlucyBhIHZhbGlk
IGludGVnZXIuIEhvd2V2ZXIsIGR1ZSB0byBpbmNvbXBsZXRlIG9yCj4gY29ycnVwdGVkIGZ0cmFj
ZSBsb2dzLCBmWzJdIG1heSBiZSBtaXNzaW5nLCBlbXB0eSwgb3Igbm9uLWV4aXN0ZW50Lgo+IAo+
IFRoaXMgY2FuIGxlYWQgdG8gdGhlIGZvbGxvd2luZyBlcnJvcjoKPiAKPiDCoMKgwqAgVHJhY2Vi
YWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgo+IMKgwqDCoMKgwqAgRmlsZSAiLi4vc2xlZXBn
cmFwaC5weSIsIGxpbmUgNzE0MiwgaW4gPG1vZHVsZT4KPiDCoMKgwqDCoMKgwqDCoCBzdGFtcCA9
IHJlcnVuVGVzdChzeXN2YWxzLm91dGRpcikKPiDCoMKgwqDCoMKgIEZpbGUgIi4uL3NsZWVwZ3Jh
cGgucHkiLCBsaW5lIDYyNTUsIGluIHJlcnVuVGVzdAo+IMKgwqDCoMKgwqDCoMKgIHRlc3RydW5z
LCBzdGFtcCA9IHByb2Nlc3NEYXRhKCkKPiDCoMKgwqDCoMKgIEZpbGUgIi4uL3NsZWVwZ3JhcGgu
cHkiLCBsaW5lIDYxODEsIGluIHByb2Nlc3NEYXRhCj4gwqDCoMKgwqDCoMKgwqAgdGVzdHJ1bnMs
IGVycm9yID0gcGFyc2VUcmFjZUxvZyhsaXZlKQo+IMKgwqDCoMKgwqAgRmlsZSAiLi4vc2xlZXBn
cmFwaC5weSIsIGxpbmUgMzQ3MCwgaW4gcGFyc2VUcmFjZUxvZwo+IMKgwqDCoMKgwqDCoMKgIHRw
LCB0ZiA9IGxvYWRUcmFjZUxvZygpCj4gwqDCoMKgwqDCoCBGaWxlICIuLi9zbGVlcGdyYXBoLnB5
IiwgbGluZSAzMzk4LCBpbiBsb2FkVHJhY2VMb2cKPiDCoMKgwqDCoMKgwqDCoCBpZiB0cC5zdGFt
cEluZm8obGluZSwgc3lzdmFscyk6Cj4gwqDCoMKgwqDCoCBGaWxlICIuLi9zbGVlcGdyYXBoLnB5
IiwgbGluZSAzMDczLCBpbiBzdGFtcEluZm8KPiDCoMKgwqDCoMKgwqDCoCBzZWxmLnBhcnNlUGxh
dGZvcm1JbmZvKGxpbmUsIHN2KQo+IMKgwqDCoMKgwqAgRmlsZSAiLi4vc2xlZXBncmFwaC5weSIs
IGxpbmUgMzE3NywgaW4gcGFyc2VQbGF0Zm9ybUluZm8KPiDCoMKgwqDCoMKgwqDCoCBzdi5kZXZw
cm9wcyA9IHNlbGYuZGV2cHJvcHMoc3YuYjY0dW56aXAoaW5mbykpCj4gwqDCoMKgwqDCoCBGaWxl
ICIuLi9zbGVlcGdyYXBoLnB5IiwgbGluZSAzMTU4LCBpbiBkZXZwcm9wcwo+IMKgwqDCoMKgwqDC
oMKgIGlmIGludChmWzJdKToKPiDCoMKgwqAgVmFsdWVFcnJvcjogaW52YWxpZCBsaXRlcmFsIGZv
ciBpbnQoKSB3aXRoIGJhc2UgMTA6ICcnCj4gCj4gVG8gcHJldmVudCB0aGlzIGNyYXNoLCBhZGQg
cHJvcGVyIHZhbGlkYXRpb24gYmVmb3JlIGFjY2Vzc2luZy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBH
b25nd2VpIExpIDxsaWdvbmd3ZWlAa3lsaW5vcy5jbj4KPiAtLS0KPiDCoHRvb2xzL3Bvd2VyL3Bt
LWdyYXBoL3NsZWVwZ3JhcGgucHkgfCAyICstCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcG93ZXIvcG0tZ3Jh
cGgvc2xlZXBncmFwaC5weSBiL3Rvb2xzL3Bvd2VyL3BtLQo+IGdyYXBoL3NsZWVwZ3JhcGgucHkK
PiBpbmRleCAxNTU1YjUxYTdkNTUuLmY2ZDE3MjI1NDgyOSAxMDA3NTUKPiAtLS0gYS90b29scy9w
b3dlci9wbS1ncmFwaC9zbGVlcGdyYXBoLnB5Cj4gKysrIGIvdG9vbHMvcG93ZXIvcG0tZ3JhcGgv
c2xlZXBncmFwaC5weQo+IEBAIC0zMTU1LDcgKzMxNTUsNyBAQCBjbGFzcyBUZXN0UHJvcHM6Cj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2ID0gZlsw
XQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByb3Bz
W2Rldl0gPSBEZXZQcm9wcygpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcHJvcHNbZGV2XS5hbHRuYW1lID0gZlsxXQo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgaW50KGZbMl0pOgo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgbGVuKGYpID4gMiBhbmQgZlsy
XSBhbmQgaW50KGZbMl0pOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcm9wc1tkZXZdLmlzYXN5bmMgPSBUcnVlCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWxzZToKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcHJvcHNbZGV2XS5pc2FzeW5jID0gRmFsc2UKClRoaXMgbG9va3MgZ29vZCwgdGhhbmtzIGZv
ciB0aGUgY2F0Y2ghIFJhcGhhZWwgY2FuIHlvdSBhcHBseSB0aGlzPwoKU2lnbmVkLW9mZi1ieTog
VG9kZCBCcmFuZHQgPHRvZGQuZS5icmFuZHRAaW50ZWwuY29tPgoK

