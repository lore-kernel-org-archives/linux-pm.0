Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023134.outbound.protection.outlook.com [52.101.127.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7676E17A30A;
	Thu, 28 May 2026 02:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779935800; cv=fail; b=We8TgBKPhdGwqGJWoUMXWFlnpMrF0pQ1OfoCnlkJqvmRxfjxhqrHdmBTz//q/4vISNQ79KUpMk/RPtjttLDIetbSsRZGWUchA9XPlWmmP2x0EH1I209KwGSYfKHHNQ+lTBNT982DNvL0RWND01qFqULujwHNa66ek2e/nJZQ1X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779935800; c=relaxed/simple;
	bh=jzDY+e+f3TbCyHBLJh74RATiSoJvww5LXKdbk6CW+m4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J9iGLqbjN0F1md0W0oorzYkZCSHc8ceHexU7lmcnd+mZnjN1yeoVOiwp5Tk2bSaZYNBT3x37ZAAD090FP7W0lyVayf5jioE+cstoDYC/kgfPNvT8plq2AFhnEOH38Z+qxechSXfvgzHDs5KisNwfXYzt9diicl/7e+ES8GevfIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=AFIHOScz; arc=fail smtp.client-ip=52.101.127.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="AFIHOScz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRdchYYFRbbxDbAL2zXV/HfHCbdYuYqmAiWvkh1xW3gkqju3fFyKQsVNKFdLsDaVBZ05N1u0XQ5rPHnyD37mmzKKQdocrn8ZrgSTA0XExgvq0aj4hFis6hT1YCQOoz1eSTP3YQ8BFWpn/MLhpI+n8a8qr4BSvLS4+Pwq3mIy2E60lHglEQlEBwnW53w6SFZVAjFcE058s5Pp0QMH5xDiInjvn4Xc3+BW39/LOhJSmugqoPMnpRjkIbK66DRMB7bahTZEEsBjZW7lyzYVniwIoC2kGcBbKk0jEFrlv3EuJagGhKShsVEx4kk5Ml/MkZ5psiN1pDY6bjLE2QwmPGLNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rh5KSvxAQusa9G/KcQoPO6hql3ORrD63jQmGyvWPpcg=;
 b=j2Va+ckyqqYuG0WcBCG9colZxEc2XpBXjq91VMBns1z001Gxnk45RzcY+AaqvJqKhOuLXqX+H+4KZBl1bpGmJOOWTZlNpb/2bVZFs81kA9LxVKGQqIX2Lo/1EEFPA3qEkBVH9XFuXwnyLkX3rbdAGurNfEy0Oq/dS6bOYgZvB17NNe87ohAqWliXF1yegq0xWWIa/S93GBORmL8AkDC+vuXJtGq7231BCD7obYryzlruDQTQFR8hxUGB6RB16qv7wcvBDhNvaQUXLbLleDrzEaTyWE/rnJqzNf6F50AiuxT3ikcXiIoN0gEtLxSLF67+9TS/KIsvh3BQcfY1k1KxFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rh5KSvxAQusa9G/KcQoPO6hql3ORrD63jQmGyvWPpcg=;
 b=AFIHOSczlbZY1ZT8FGYO/aiT21+x1fxmUAz4okP7nImCDsJVep0UlxlU7YHkXHd61x8UQPUXtJc9VMBi1F+5KTbfCSKmPvTCUotqc/jVFpqiBOl5E1gLRlFdh3PZUg33UP+82HREM7wnERen6BhaKecJ0vOH0mGNhCc9EjrgY8s=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by JH0PR04MB7250.apcprd04.prod.outlook.com
 (2603:1096:990:3e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 02:36:34 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 02:36:34 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>
CC: Pu Hu <hupu@transsion.com>, Jiazi Li <jiazi.li@transsion.com>,
	"christian.loehle@arm.com" <christian.loehle@arm.com>, "qyousef@layalina.io"
	<qyousef@layalina.io>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] sched/fair: Revert boost in cpu_util()
Thread-Topic: [PATCH v2] sched/fair: Revert boost in cpu_util()
Thread-Index: AQHc7krMD0BpqZESjE6npLVWtH3psg==
Date: Thu, 28 May 2026 02:36:34 +0000
Message-ID: <20260528023611.2433-1-hongyan.xia@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|JH0PR04MB7250:EE_
x-ms-office365-filtering-correlation-id: 5925b562-2843-4333-3312-08debc61ef2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|38070700021|921020|11063799006|56012099006;
x-microsoft-antispam-message-info:
 DtcHLIQL8nyOdKYlVv12wMLMXhbrtdI5wh7p/w+S04bIRtTYT8nGw1EBSk1GMRxntCreymO0+OfdTLX7w3taOFSvmISIp7ZgnR4C8CBJ20T23xM87Z8N9tY7TIgQ7guzYNkNakP4d/P1Z8h5FY/UI0VXIV2s03WX7+HPxMxfFLfWVUKO3r2b9pe5lvpw+tW8zG9Cv39E7g9cRzGvOrYbi2dJz5CEUdqvr+BMIeYKzm/FI/EfTLAEArSry5bamyAEupkUDjKBK4+2D0SIjRagL6Ly7Bt3Ri3CkXIqlsZ/btgYHGIqeY2zOdLCgjw/6V33YbYvZhmXmbmn9KSBNy9+KeYXdlut60di0va9YGUGeEtEYIzl9ScX1KiBa18f18WuxM88j5SJLrdZxU9myzUVysXWnGh11ZT9B6RSckWg4sfo0SZcON0dwCE6nNX4YbDvWAszw9uIn/R/WxvCdKlingVzqHzAZ3M+JCAfqfv4K0PWJZ4aCShOQszOlL/yYZzlsKZlj4FqZlAr9Xku1fXD67PsAfCzk+br9Zoj+ZtDk8X01zMD7jwD8yAgaCr+DI8+9+ly8sHhRZlu2z97X4oNwK9agLKi3mtxslL2XMRPmesbsbO6ztyITz7KRpjF2mBCSlqymnZeAl+sfryix/1aVk2BvZStA3cXzx+cYQrdous+srYNIfouELFa3dWWkdcNneFI3yhz7OH2hGwSOFXQkmJ+ub922lRtrzgsPK1YxGEBkPyyzc/or3H70/TjdQ8inR9qjmV24h34fDDcWUp/QQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(38070700021)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?u1kKh0PO2ST/NP32rgVzUA6GhJ9oqtyK2pYqiaBeWcKnn9KG8m0WeWnt9A?=
 =?iso-8859-1?Q?ZvJX8ZXciXOW36L59qP5nXNWSAqDwlFnKVDvowRI8NJvfvj2xNcXtUeNU3?=
 =?iso-8859-1?Q?eciKDbefQzqJYWUKRV0uucujMIseMnysNNCc+JyDIXh/4EpzY3+FhyzIZe?=
 =?iso-8859-1?Q?s9G0UiLEiBCKaOt4ZOKmIYYHqHLb1AXCkMYifMWsQ8pImPhxhIdVUUX0pQ?=
 =?iso-8859-1?Q?jLirD4pl2w8MG5WcsOqDysh3D0VqEbAq2UUvMgCoyKs8e3Jp7XUlDwR9VZ?=
 =?iso-8859-1?Q?TX3uofqWI8QglN0NQyjTm2R/H7Lli3HzYkf0bI+CpFfr1lKYpGEdXv8nrZ?=
 =?iso-8859-1?Q?LmTGUgYASjQVBvuAqKaQEurPmCx6FrADf9oH0QE67w0jNXeP6K7YEW+YdD?=
 =?iso-8859-1?Q?yryImKLUJ7eQc6aRRgSJbWmif0s90n+WXsAzxehLKcMRGrN0puCyZKQtl5?=
 =?iso-8859-1?Q?OnWyA57YRea22zaST5W94o0XUC83QCA7kotHeKZP5hT6ad6fa3tTArmvnr?=
 =?iso-8859-1?Q?7CFNKF1IWOEwd/CcDfZZYTgScMXIhACCeZbTVK5N5py/kDHRzn6OuUwWyi?=
 =?iso-8859-1?Q?LEhRIwiAi+q/8QBi2o4QB+uzRTQYwMtd/f+48bjEbXpvsE84g7XkCh3eSU?=
 =?iso-8859-1?Q?TkALkYHE+qoDlHiHgVXq6ainZYgiThO/Av/bLE6/O2KxFpGvvBy8eDu8Ye?=
 =?iso-8859-1?Q?G5SMQwedaqx4kqxcHkbSB58z/UL80/6VXyH00C0JtRtv7mblvGUv7jqjMn?=
 =?iso-8859-1?Q?jzMfY9h+6VOPQXhw+Fv01b98xknfTXMVanZ4MQEpoPltP+lrzxtLE0CW0y?=
 =?iso-8859-1?Q?7IUiXhfdDD7z1EhhqdfUCyqoM3JjKMJ5/+/7VehfB34zGry+JPeDUiw8Tv?=
 =?iso-8859-1?Q?gsRWdXLXF24yXRHujjn6Iqt0wHbBCpqkSNqrzcakmu0yxoibFqynG8/YdH?=
 =?iso-8859-1?Q?Ew/P9XDY7xcj0rH+0ueLhFUnHSLjwN2Qw3uWAaoGWCH9OYtsJD/viOHw/L?=
 =?iso-8859-1?Q?wXNEdlkzHgqBaTTziqv9xlZentR0EA9oYr7BDDtqiUS9gHxtf123JXy/DW?=
 =?iso-8859-1?Q?eZN76X5wfKm1jxu1afbgPd4OV56bwJgkYOI0amRl8bq9hnNJLibuDqZyMz?=
 =?iso-8859-1?Q?+Gz3yrbV10WW+ooAelqeu8RkKYPHvNH6KOKXGDyt6qRFh6yWw2nzrBoXG6?=
 =?iso-8859-1?Q?Nt3m8fCY7Qv7H0RbOBcJxDldGaDjafD2Xua/z11Y82QzmVBrM031mkBfuE?=
 =?iso-8859-1?Q?Hd/jIdzyOsaWnkQGxExFaOH3aYE/sQ61BE2RdsMe23reDCKjIsFwL0YQYn?=
 =?iso-8859-1?Q?LchHP+AnLv2TIAW71K0FgngTur65HeHpM/0LEayocHxnUmDfSgAccSm8Ij?=
 =?iso-8859-1?Q?F/IrTfG+DkbcE6rEqRfmUkjl0W+I01KHVxaLEiaX5sx5Xd6W2J0ELyLaIF?=
 =?iso-8859-1?Q?5oK3czWoU6nLYBcjFfMJSgV8RUODlygzDLEL46xlwqzo4B2iqsTA3ouEve?=
 =?iso-8859-1?Q?9Mx207KOuv+uiSMXxv6nPBixSnjyGQs+AMkbJc4ag/UFeNLJxJp7Zk+KL3?=
 =?iso-8859-1?Q?LKMSW3v4Mk2crmK6SMNPps4wQ0AN9MZqgWdPIbaF7FYwCgIEZPJS6YVJ1o?=
 =?iso-8859-1?Q?WXZS0GMfb4OxizQAIPaK0Kl8/h2tX6fruSLiOIEp88fUT/7FZ5FKhhhw57?=
 =?iso-8859-1?Q?LE79zoh0DrY+lEwS4IW0DZm3uKBJ2hIEQWoYg63Aj390G8zkgSzzb7diay?=
 =?iso-8859-1?Q?auzkn2taT0Xd/y7nOgl4X20utKR6x4HqkAkrbH/3Qt4OJxAnuBXzjppe3J?=
 =?iso-8859-1?Q?Zn4tZLpk8w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6196.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5925b562-2843-4333-3312-08debc61ef2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 02:36:34.3328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1AS7Um1AsvkdEV0upSnogcfLxOYsC3kl0HrFB4lIsvT1r1kAK/0yuNgONUfwn5SuFa1Kf+tgj/d1igJTHss0uYPGnq8Cyh2mESA8z14phcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7250

From: Hongyan Xia <hongyan.xia@transsion.com>=0A=
=0A=
We have seen a massive power consumption regression (20% SoC power=0A=
increase in many apps) after updating our kernel. After bisection we=0A=
pinpointed the regression to the cpu_util(boost) feature. After=0A=
reverting the boost feature the massive energy regression is gone.=0A=
Detailed trace analysis down below. The regression is found across quite=0A=
many apps but Youtube is one of the worst offenders. Some energy=0A=
benchmark numbers are here.=0A=
=0A=
Youtube 1080p60fps video benchmark:=0A=
                FPS   SoC Power  diff=0A=
w/  boost      59.94   913.6mW=0A=
w/o boost      59.93   720.4mW  -21.15%=0A=
=0A=
Mobile Legends (gaming)=0A=
               FPS   sdev   Total power  diff=0A=
w/  boost     120.16  0.47   3294.10mW=0A=
w/o boost     120.07  0.56   2996.09mW  -9.05%=0A=
=0A=
Genshin Impact (gaming, medium quality)=0A=
                FPS   sdev  Total power  diff=0A=
w/  boost      60.05  0.34   6215.84mW=0A=
w/o boost      60.03  0.35   5695.46mW  -8.37%=0A=
=0A=
Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>=0A=
=0A=
---=0A=
Changed in v2:=0A=
- Sync all comments with code changes.=0A=
- Update commit message with more benchmark numbers.=0A=
=0A=
Analysis:=0A=
=0A=
We found several problems that result in the power spike:=0A=
=0A=
1. Arithmetic should not happen between util_avg and runnable_avg:=0A=
=0A=
After util =3D max(util, runnable) which potentially picks runnable value=
=0A=
in cpu_util(), we then add or subtract task util values from it. This=0A=
produces a value that is half-runnable-half-util which is ill-defined.=0A=
This alone should be a warning sign. This breaks EAS calculations in=0A=
many cases, leading to sub-optimal task placements.=0A=
=0A=
2. Using the absolute value of runnable_avg to drive frequency is=0A=
   too high to be reasonable:=0A=
=0A=
Schedutil use runnable in a _relative_ way to util to know whether there=0A=
is contention in several places. However, the _absolute_ value should=0A=
not be used like util. Runnable_avg tends to be significantly higher,=0A=
making it much easier to saturate frequency.=0A=
=0A=
For example, if three tasks each with a util of 100 contend on the same=0A=
rq, the rq util is 300 but runnable_avg shoots up to 600, which is often=0A=
much higher than needed.=0A=
=0A=
3. Runnable_avg may not even reflect true contention:=0A=
=0A=
When tasks are dependent, the bottleneck is often the data flow between=0A=
tasks, not the contention seen by runnable_avg. Boosting frequency with=0A=
runnable in such scenarios wastes power without performance benefits.=0A=
=0A=
We found 1 has minor power regression but 2 and 3 regresses power=0A=
significantly. We have seen multiple applications with the=0A=
producer-consumer model with many worker threads suffer. When there is=0A=
IPC between producer and consumer, boosting frequency blindly does not=0A=
help performance at all if consumer is limited by how much data is flown=0A=
through. Youtube suffer from 1, 2 and 3 at the same time, leading to a=0A=
total SoC power regression of 20% shown in the results above.=0A=
=0A=
---=0A=
 kernel/sched/cpufreq_schedutil.c |  2 +-=0A=
 kernel/sched/fair.c              | 34 ++++++++------------------------=0A=
 kernel/sched/sched.h             |  1 -=0A=
 3 files changed, 9 insertions(+), 28 deletions(-)=0A=
=0A=
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedu=
til.c=0A=
index ae9fd211cec1..ba867192513b 100644=0A=
--- a/kernel/sched/cpufreq_schedutil.c=0A=
+++ b/kernel/sched/cpufreq_schedutil.c=0A=
@@ -228,7 +228,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu, un=
signed long boost)=0A=
 	unsigned long min, max, util =3D scx_cpuperf_target(sg_cpu->cpu);=0A=
 =0A=
 	if (!scx_switched_all())=0A=
-		util +=3D cpu_util_cfs_boost(sg_cpu->cpu);=0A=
+		util +=3D cpu_util_cfs(sg_cpu->cpu);=0A=
 	util =3D effective_cpu_util(sg_cpu->cpu, util, &min, &max);=0A=
 	util =3D max(util, boost);=0A=
 	sg_cpu->bw_min =3D min;=0A=
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c=0A=
index 728965851842..ecf8b4860951 100644=0A=
--- a/kernel/sched/fair.c=0A=
+++ b/kernel/sched/fair.c=0A=
@@ -8192,7 +8192,6 @@ static int select_idle_sibling(struct task_struct *p,=
 int prev, int target)=0A=
  * @cpu: the CPU to get the utilization for=0A=
  * @p: task for which the CPU utilization should be predicted or NULL=0A=
  * @dst_cpu: CPU @p migrates to, -1 if @p moves from @cpu or @p =3D=3D NUL=
L=0A=
- * @boost: 1 to enable boosting, otherwise 0=0A=
  *=0A=
  * The unit of the return value must be the same as the one of CPU capacit=
y=0A=
  * so that CPU utilization can be compared with CPU capacity.=0A=
@@ -8210,12 +8209,6 @@ static int select_idle_sibling(struct task_struct *p=
, int prev, int target)=0A=
  * be when a long-sleeping task wakes up. The contribution to CPU utilizat=
ion=0A=
  * of such a task would be significantly decayed at this point of time.=0A=
  *=0A=
- * Boosted CPU utilization is defined as max(CPU runnable, CPU utilization=
).=0A=
- * CPU contention for CFS tasks can be detected by CPU runnable > CPU=0A=
- * utilization. Boosting is implemented in cpu_util() so that internal=0A=
- * users (e.g. EAS) can use it next to external users (e.g. schedutil),=0A=
- * latter via cpu_util_cfs_boost().=0A=
- *=0A=
  * CPU utilization can be higher than the current CPU capacity=0A=
  * (f_curr/f_max * max CPU capacity) or even the max CPU capacity because=
=0A=
  * of rounding errors as well as task migrations or wakeups of new tasks.=
=0A=
@@ -8226,19 +8219,13 @@ static int select_idle_sibling(struct task_struct *=
p, int prev, int target)=0A=
  * though since this is useful for predicting the CPU capacity required=0A=
  * after task migrations (scheduler-driven DVFS).=0A=
  *=0A=
- * Return: (Boosted) (estimated) utilization for the specified CPU.=0A=
+ * Return: (Estimated) utilization for the specified CPU.=0A=
  */=0A=
 static unsigned long=0A=
-cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)=0A=
+cpu_util(int cpu, struct task_struct *p, int dst_cpu)=0A=
 {=0A=
 	struct cfs_rq *cfs_rq =3D &cpu_rq(cpu)->cfs;=0A=
 	unsigned long util =3D READ_ONCE(cfs_rq->avg.util_avg);=0A=
-	unsigned long runnable;=0A=
-=0A=
-	if (boost) {=0A=
-		runnable =3D READ_ONCE(cfs_rq->avg.runnable_avg);=0A=
-		util =3D max(util, runnable);=0A=
-	}=0A=
 =0A=
 	/*=0A=
 	 * If @dst_cpu is -1 or @p migrates from @cpu to @dst_cpu remove its=0A=
@@ -8295,12 +8282,7 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu=
, int boost)=0A=
 =0A=
 unsigned long cpu_util_cfs(int cpu)=0A=
 {=0A=
-	return cpu_util(cpu, NULL, -1, 0);=0A=
-}=0A=
-=0A=
-unsigned long cpu_util_cfs_boost(int cpu)=0A=
-{=0A=
-	return cpu_util(cpu, NULL, -1, 1);=0A=
+	return cpu_util(cpu, NULL, -1);=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -8322,7 +8304,7 @@ static unsigned long cpu_util_without(int cpu, struct=
 task_struct *p)=0A=
 	if (cpu !=3D task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))=0A=
 		p =3D NULL;=0A=
 =0A=
-	return cpu_util(cpu, p, -1, 0);=0A=
+	return cpu_util(cpu, p, -1);=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -8489,7 +8471,7 @@ static inline void eenv_pd_busy_time(struct energy_en=
v *eenv,=0A=
 	int cpu;=0A=
 =0A=
 	for_each_cpu(cpu, pd_cpus) {=0A=
-		unsigned long util =3D cpu_util(cpu, p, -1, 0);=0A=
+		unsigned long util =3D cpu_util(cpu, p, -1);=0A=
 =0A=
 		busy_time +=3D effective_cpu_util(cpu, util, NULL, NULL);=0A=
 	}=0A=
@@ -8513,7 +8495,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpum=
ask *pd_cpus,=0A=
 =0A=
 	for_each_cpu(cpu, pd_cpus) {=0A=
 		struct task_struct *tsk =3D (cpu =3D=3D dst_cpu) ? p : NULL;=0A=
-		unsigned long util =3D cpu_util(cpu, p, dst_cpu, 1);=0A=
+		unsigned long util =3D cpu_util(cpu, p, dst_cpu);=0A=
 		unsigned long eff_util, min, max;=0A=
 =0A=
 		/*=0A=
@@ -8675,7 +8657,7 @@ static int find_energy_efficient_cpu(struct task_stru=
ct *p, int prev_cpu)=0A=
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))=0A=
 				continue;=0A=
 =0A=
-			util =3D cpu_util(cpu, p, cpu, 0);=0A=
+			util =3D cpu_util(cpu, p, cpu);=0A=
 			cpu_cap =3D capacity_of(cpu);=0A=
 =0A=
 			/*=0A=
@@ -11848,7 +11830,7 @@ static struct rq *sched_balance_find_src_rq(struct =
lb_env *env,=0A=
 			break;=0A=
 =0A=
 		case migrate_util:=0A=
-			util =3D cpu_util_cfs_boost(i);=0A=
+			util =3D cpu_util_cfs(i);=0A=
 =0A=
 			/*=0A=
 			 * Don't try to pull utilization from a CPU with one=0A=
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h=0A=
index 9f63b15d309d..1c934dd126b2 100644=0A=
--- a/kernel/sched/sched.h=0A=
+++ b/kernel/sched/sched.h=0A=
@@ -3551,7 +3551,6 @@ static inline unsigned long cpu_util_dl(struct rq *rq=
)=0A=
 =0A=
 =0A=
 extern unsigned long cpu_util_cfs(int cpu);=0A=
-extern unsigned long cpu_util_cfs_boost(int cpu);=0A=
 =0A=
 static inline unsigned long cpu_util_rt(struct rq *rq)=0A=
 {=0A=
-- =0A=
2.47.3=0A=
=0A=
