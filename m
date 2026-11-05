Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.226.244.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862482;
	b=xjKsYHb/0Ecx8i7QP0G7RL9L5/uY6HooJvsl+flQX2aF87dyGEOFPxwMajrc7L8S4SBi
	 cMgFSdUU7xDiFGlD33JX8cbEKdX8sTsV8HC5eMUSHE/G6Om+mNXgx8wRSi6VY2u+JvYCv
	 hxvk3/Dh1vAlEPGxR+TrnU96YOpR53B9k3sCm/gak1zP5tqMrug4XbZc+vNv8SS+hn+6K
	 GC5xXj70DDNKearWLBcW2gsYZo8DImx/EAtP0MspkdboTUj6+FflNM20h6J/icAwK92oH
	 DH+IqBxsfzJtH8+Asa7y32YQufhW/BWpLhdMbUc/LX+matQvIgGU9CXKWxMNu22gkbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862482;
	h=DMARC-Filter:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=qb91bGWABT9hIW+ineaegdCnCyxCvqX2gy9oqaZe+jg=;
	b=EIGjLRxEjHwBnLhExAH9f+eQgvwtuB70DgPlX/9GvI5W4pj9LGOKLq53fPTgOxImTpUQ
	 Rvuqxvo6U0aG7fY+hLEOh7xfwG8XTm6ScsRW2iwF3XtC+UK3B87+1D0HfeHVLgdqnZR6j
	 IS2A7LuCrMZqBWSO3mBJ6KB7UFEMhB7uUfrxSeOhlWyc0hWxX/bUw7MthRJInOqXgtXsW
	 1S7fvUkd738Rb6PYLX8w8fdC4h90t1PFSxJKDPB9uvbxfxUfYlUjxu/qyZ6yqvt4feLKu
	 CzX+P76RnfmGsRKFr5R+oKfqSwzrVnWNHFDp3yih4uG++8fr19s7Ep9erMiMKCBVFtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xiaomi.com;
	spf=pass smtp.mailfrom=xiaomi.com;
	arc=none smtp.remote-ip=207.226.244.123
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55694606A31B
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 07:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55694606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: X5eX14tKR1G7WHtx2Y/MIg==
X-CSE-MsgGUID: biHiAgL+SjuAKqfJztdKAA==
X-IronPort-AV: E=Sophos;i="6.27,196,1786982400"; 
   d="scan'208";a="194318370"
From: Kaiqian Zhu <zhukaiqian@xiaomi.com>
To: Ulf Hansson <ulfh@kernel.org>
CC: Kaiqian Zhu <zhukaiqian@xiaomi.com>, <rafael@kernel.org>,
	<sudeep.holla@kernel.org>, <daniel.lezcano@kernel.org>,
	<christian.loehle@arm.com>, <linux-pm@vger.kernel.org>
Subject: [PING] Re: cpuidle: psci: Fix CPU PM domain state after failed runtime
Date: Thu, 5 Nov 2026 15:06:31 +0800
Message-ID: <20261105070658.18211-1-zhukaiqian@xiaomi.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021031709.42644-1-zhukaiqian@xiaomi.com>
References: <20261021031709.42644-1-zhukaiqian@xiaomi.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX02.mioffice.cn (10.237.8.122) To YZ-MBX03.mioffice.cn
 (10.237.88.123)

Hi Ulf,

Gentle ping for this genpd patch.
Add Sudeep, Daniel and Christian as an extra reviewer.
Please let me know if anything needs to be adjusted.

Link: https://lore.kernel.org/r/20261021031709.42644-1-zhukaiqian@xiaomi.co=
m

Thanks,
Kaiqian
#/******=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=D0=D0=A1=C3=D7=
=B9=AB=CB=BE=B5=C4=B1=A3=C3=DC=D0=C5=CF=A2=A3=AC=BD=F6=CF=DE=D3=DA=B7=A2=CB=
=CD=B8=F8=C9=CF=C3=E6=B5=D8=D6=B7=D6=D0=C1=D0=B3=F6=B5=C4=B8=F6=C8=CB=BB=F2=
=C8=BA=D7=E9=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=C6=E4=CB=FB=C8=CB=D2=D4=C8=CE=BA=
=CE=D0=CE=CA=BD=CA=B9=D3=C3=A3=A8=B0=FC=C0=A8=B5=AB=B2=BB=CF=DE=D3=DA=C8=AB=
=B2=BF=BB=F2=B2=BF=B7=D6=B5=D8=D0=B9=C2=B6=A1=A2=B8=B4=D6=C6=A1=A2=BB=F2=C9=
=A2=B7=A2=A3=A9=B1=BE=D3=CA=BC=FE=D6=D0=B5=C4=D0=C5=CF=A2=A1=A3=C8=E7=B9=FB=
=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC=C7=EB=C4=FA=C1=A2=BC=B4=B5=
=E7=BB=B0=BB=F2=D3=CA=BC=FE=CD=A8=D6=AA=B7=A2=BC=FE=C8=CB=B2=A2=C9=BE=B3=FD=
=B1=BE=D3=CA=BC=FE=A3=A1 This e-mail and its attachments contain confidenti=
al information from XIAOMI, which is intended only for the person or entity=
 whose address is listed above. Any use of the information contained herein=
 in any way (including, but not limited to, total or partial disclosure, re=
production, or dissemination) by persons other than the intended recipient(=
s) is prohibited. If you receive this e-mail in error, please notify the se=
nder by phone or email immediately and delete it!******/#
