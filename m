Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8067F3876A1;
	Tue,  7 Jul 2026 06:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405621; cv=fail; b=IXO7exvh784Rz9RSsnOrjzIG1LYnjd8qHXft240kA2yWcRS0N8lQiJirM3Ct/5OgAD69pY0JKgDizeq3zH+5mj7sG36Eny5Rsz8tZ2FDu8nRIoOBHKmNn3QRwTSUAqYeNoDSvoGEzEpzYX/u47bWmETppI90v1o3u6Ii3/q2qnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405621; c=relaxed/simple;
	bh=NNo3jpz9BaxK6ygd0NluB8EJeF6t24k7+NloXF6+eRo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p0Gb6QEXlhiyWZJqPK6L1R02LNrOHkBwYdE0wEZ41VG1dmqGk4qswD/5PT0t20pcgQ5hpYsNh/oq7I0or04amEAfQ4G3XilFCafuekT/Hec/bNJzruFYz/u7mbulPueaZEOKEImYSzfE+pQfxS8pkJ4koAiihv+t/hMg00uu+Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=In2SPAlk; arc=fail smtp.client-ip=52.101.46.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="In2SPAlk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lp43ll6QlGhbiaCDpSmFcb7AKF/ZuFGfiTLFIJBiyvz7JTqH49qVpzhch1M1J9hdOVI/9PT5JkVgY6wXr35Mp1VWaxjgJ/ZYxwmnbA/h9sC8lvdTZGvOreXFoKC07/oEImxGc7aOUnfiE2RhWx5lYPy1I5+PQpWpX6VzQFsgde3LvNlufk39EaQnML8mCGxfI0MhRwuc1iThMi1vyed6cV2tRP4HvC9p3ISDu5fUZVFQPmTAkRczOmS3IyUltcd/MhTbG9SVUSrzJy7xftTS+Std5+O3j+RuYx8d8Vo29faQX1LjxkxWgF63spwR9216qeFFM/Vq1eW/GbZBB02dGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uM09G4xLk9nXuZB6yHRK9bL4LZN2UgTaOvZ4oG7cmFU=;
 b=fnmqW42pkXfZ9LbgFMRnQUL8ldrUPYPVaU9ZW4kwwHM6XU2DR8in2J5ZReEbORXMhWEnFeJ1jKY1JXgsnnlFm5fZ/CPuMXp89gdbUuuI7oCHYX7lfQWuKV7kTUwo+SV1353pQ/+Fw6kHD7GIrnMFN2C9WE0EFiVZfCT2dJHnXXIUzsilpQCxyaMJkPTzpjJE+JQtFbL8ZaRjCdl3Lgz3qqbNIPBgOpbS7Lj2AVH7ZozBcJZYe97n2ssdb3vGVHQ3aCXXh877/2XCtE971Fr6UCLDsbLy8mXATiHN3V0j7B/Em/40jK0UJI4+//D1r0lxxfABSjVdrS8e6gPHf9xRxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uM09G4xLk9nXuZB6yHRK9bL4LZN2UgTaOvZ4oG7cmFU=;
 b=In2SPAlkkidww+mQXBcgUfycMqONYBaMdGEmKgq9oKklrjh4DArTU/uymOIZVbSkVyQl8grLfXI2mjVF/ErM6nuPAMJeqFzN1XHnmI6ZM2CviL0QL2/HqpgUgcQkSdLFzbi5N1OgESDyFW5MhMuJwIKe/d5xvCaTYvPLgpD/LfJXRYn8hs3Jsc013TZNIi5Gs7wf3bmy4iYT3U4JSj+ichNst5pqH4U0tvmCaQ5c+bPu8F3HRvVUkTanpZqrLi0sEtWBY836njca49+Sbs4Z4RLXF4lE+3pa7E0i0cbXHyGbY97SeJp9jwymH80hDZMpFbYmgNB1xFqdD2ZNsA9rsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 06:26:57 +0000
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9]) by SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 06:26:57 +0000
Message-ID: <9e49015d-f800-4396-a5be-c93c35ac6b63@nvidia.com>
Date: Tue, 7 Jul 2026 07:26:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] pmdomain: tegra: Add support for multi-socket
 platforms
To: Ulf Hansson <ulfh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20260602193248.443101-1-jonathanh@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260602193248.443101-1-jonathanh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::12) To DM4PR12MB6063.namprd12.prod.outlook.com
 (2603:10b6:8:b1::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6051:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c561e63-0607-4671-7389-08dedbf0be47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|23010399003|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	AGxq0QOpNl/ibRIhSQ6nzYO0BpYq/efCDeSKV4dsNX/2qjJQOLvLNNejzwDz6DMh1fsofOGuMrMM4yY7eGyfe1sD3i9aWpkwKdxKdUJ4VWPsCF50wGm/vCHych80lLBKGhLuJ10djzNbfeU6winzlC7dundQJL++WPFqvXqvBGYoqI2Uw33KxitTI7FKzOFSPklGZiX+OggP4QcZ0IZqouUjRIA9xgqPnV+888ZsiHVwp6Q/F737Jsy8UCy4a+zyG6lQ4BDRS4Q6rNeJJg+h5uy7cVnW1R/Qbl+jhUGTtOswWsW7P/+IfFYArpmj/rNexHlbTvnivZ6Kar31le3kyUkqyV8GyEkyx7nOQP9lWJTrPF1uyP5U44ly0dzRWl+MvGqno93LMyEo2DNGmhc9HKlscneSfBcd0xFxj8hz1mincemnmPfFwfYBJm5sFUFxmQLDgXRHO0UO3N9/rdoguB05MwbeX95rXFfjhlrU4UjFYJAaDnkMvQ4/+vQwrHMZRuJZktzqci0Ojzql2gkPUIK/13qQlbty49UUH/JGQUN28rzGKYH15XjpiqkQE+O16svMfuWQW41IxPojsD9HYDuH1DJbA1zf9ZajGg+uSCf8Hqecs457mx0J5ZaKS6pFOpUTRNwMsPIGXDw/nqXxqFCFBc0lg+fOw/q0qMM01QE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6051.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVVuWktYbGk3T2R2c1A0a05GdGpoRU9JWllOVDFqYVhmazNwc1Q0WUdZVlc5?=
 =?utf-8?B?YjhyTFQrQ0doSGlMSjVVdjNjNzVQZUl5TzBQdnhLNG8ydkxaTDV0MzFwQ3lU?=
 =?utf-8?B?RmNEcTFMNmFFbWNQT1pKbHM4U0F5ZGZ3cElGa3NVaU1HN3lkWmFxQlVkRFIr?=
 =?utf-8?B?VDk5dyt0RVYxUUFZSnRVWmlRemF6UXZPY0ZYcEdwYUpidzdUQW1rMTg3VDhQ?=
 =?utf-8?B?NWlTUG9aeUVKK2dBemhnTXlPc2tMWnM0SzZOWTFiUUVYL0hGOUJ4VkRUU3hD?=
 =?utf-8?B?WlArSzdJUlVlMXlRTVBzaUE5M2xYWnpOeVJERUJHbEpEaHJRb09OekJiM3p0?=
 =?utf-8?B?OEpoMjIxQkMvbjlSbDZNS2JuL1ZHVFExdFRKMXJLTVFocWJIaURyZGJmaURZ?=
 =?utf-8?B?dnFrbHJGY2o2OTNzZHhjT0FKcXh2Ly9ENUlBeWRlT3IwMG5weFdOVk5xbWZv?=
 =?utf-8?B?STNibTRLN0w0czZGQXpuQzFTZTBMVGt4SVQxZFZyRzhrTldwbmJBU21QOCtn?=
 =?utf-8?B?WGVLeGVkei82MDd4OWpOa3d6RzZmbHlmZ1c1S2lDMGdrUFVRblk2dXh2NHZj?=
 =?utf-8?B?bGErODlKL05weXFjeHVpaXE3MTYrWUIyUUc3V0R6SVJmRk8zaFZBU1dKaTU0?=
 =?utf-8?B?ZzVsOTBXTS9SYWRVak5XSlJTajlIWFF6RVZBM1FpOFFUOUVwa3VsMmkreEFm?=
 =?utf-8?B?cXBHbTNLU0RzZDl0TWNzRkp5bERaYS9NdXBrUDdHeFdGYWVXVTNzWTU1Rzkx?=
 =?utf-8?B?NDBwbXFDeERraGRCdnp5ZHMxTFdkQVJBdmQ5elZTTFQwZ0k1STdVUmN4WDBJ?=
 =?utf-8?B?Qzl1dkk2WEE1dEFDUUtjajFJOHQ1TUY5ZUd3YkcyVFdrSmh4N2drRTFFSW1T?=
 =?utf-8?B?d2k2b3F2bXlQS2h0Yk5OUmJmRXltZmlaR0lFNzJCMmxUQS9ubVdscXp6TW9I?=
 =?utf-8?B?OGNselFoRHFmK1R5OUd3M0JYbDdpaWFaQVluNWhKSDJWWUk0ZnppOUttRTZi?=
 =?utf-8?B?ZTJUcjFEZUxxelo4UHdyVndWTVdVTGJqbE16RUYyaUpya0JEVXhhK0xtRFd5?=
 =?utf-8?B?VkZBVU16NEtmZjlMRENRWjZmN2IwQ0JGMXpkUmswZDFKemp1T2Y4dVlLL1Va?=
 =?utf-8?B?ODRyUWk3S09OVk9XYlVCS0RiTTNXQWhxYUNURmZjcDZTb3c4dFBMTjMvMVpG?=
 =?utf-8?B?ZnN0QW9HWUJLbFRFZlBxV2hERXFaMHo0V2VuOFZJbWV5RlEvOHZBRnZHUDAy?=
 =?utf-8?B?b29vd2gwRFpqdmZPeTlSQzBUcU8yR09MblFCSVFTRzNScHlpZXY5SEZFdk5x?=
 =?utf-8?B?Y1VQK2RRUUdzTGJiZUNoMlRTTVIrL0IvclNTbGtTZzBnMVBIbVZxeFg2WXMz?=
 =?utf-8?B?ZlBpcGN4NkVnNkpXRHpob1VVL3RFZFFEZXBrcXNySTgxekxhQTQ1a2tXRFRl?=
 =?utf-8?B?UTNMVkhnRXFwa1dnMkdPTnpXWXk0VHJ2Wkg4RlBBZWc5NGk1akIvd0oxSVph?=
 =?utf-8?B?MzZoSnEvZXNCbWZERUQ5ejFkNXR1VDR4WEhLS0lacWZGMlJqd2tUNGwvOVZx?=
 =?utf-8?B?Z2haVnZFTmpBbXN5WVNCcGxwcitWZDZVVW9OeEcrRXRVbTgrcldTVURsRFpI?=
 =?utf-8?B?Qm4zWFlTMk0rYm84Uk5CUDZ5MEpwWXQ1OVlSRG5wTzVENHJBOTR0NTluWXhD?=
 =?utf-8?B?V242NFc5b3RReVVCWGs5WHFUTTdpTzFmaU1RdFdEd2diWTRvZXE3OTQxSnJJ?=
 =?utf-8?B?V09CTDU2WGRHUTEyRVRYeXFQamVnQjZPTlVwZmdkZE9zSC9VRVdsekJMMFRD?=
 =?utf-8?B?QkhiZDhJRW9tcUhsaTU5Zm9yWXg0M1dzbFZDdEZKSW5sSzF0ZGJ4RTBHaVpY?=
 =?utf-8?B?eGJWUjY5UGU1SE5xV3J0MGliWCsxRzZxU2REd3pDaXdFVkxDekhvamllVTJx?=
 =?utf-8?B?RXZKSnJYVnk0VkVPVFhDQmhjNnBUbWU5cHN4RjZ2UDcvakhqeW4vbzE1VUtp?=
 =?utf-8?B?bUNuZWlNS21CekErWjVwcFk5VnFuQU4yNnpYeFl5eXV1a0c2VmYrTVd4bmM2?=
 =?utf-8?B?dUVUMGZSaXpOSnhla2xpeFVTbm5IKzBaSWp0STJ5SFdzby9ML0NRRTJvSnBB?=
 =?utf-8?B?NkZrNzhVelRhd1JFRHFlcDlFaHRJRWRuU2pzR3IyUmdXRTIvR3dwVDJTbGox?=
 =?utf-8?B?TWlBRXBpd01zSDJXZUtMNFNtNTdZc0x3b08vbkxNV1RTdE1FWnkzUHJ2UkV4?=
 =?utf-8?B?bHpjRG8ySVRPUkozdWFkcHRtRERvRHFmQTBuY3dITGhDOHJoVDRPYytpcVNp?=
 =?utf-8?B?c2Y5TWNieHI5M2trSVFSWGxLL1gzTEl4U3MxbFBWOGVraUVCbEo5YjFPdHFH?=
 =?utf-8?Q?eaKs9tBn+sLZh8LLFtFaLMTcqUzyXlTvFwSytI/373+Y5?=
X-MS-Exchange-AntiSpam-MessageData-1: Bnc+FB7tbSyn/Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c561e63-0607-4671-7389-08dedbf0be47
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 06:26:57.7368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xs/DOTih4z6N1uR+68aiQa9XulyKoaYOi7DFNTibUGKLfYPSvThEZODqlISA+0sFvAMftVBKc39lTqBsXZ8mJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088

Hi Ulf,

On 02/06/2026 20:32, Jon Hunter wrote:
> On multi-socket platforms each socket has its own BPMP that is
> registered with the kernel. For such platforms prefix the NUMA ID for
> each socket to the BPMP powergate name to ensure there is a unique name
> for each power-domain. Note that we only add the NUMA ID for powergates
> that return a valid name because an invalid name indicates that the
> powergate ID is not supported.
> 
> Note the check for the NULL string is moved into the function
> tegra_bpmp_powergate_get_name(), because in the multi-socket case we
> must only add the prefix if we receive a valid name. A NULL string
> indicates that there is no valid powergate associated with the ID that
> is being queried.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> Changes since V2:
> - Moved the test for a NULL string to a common location that can be
>    used for both single and multi-socket platforms.
> Changes since V1:
> - Use NUMA ID as a prefix and not a suffix for the powergate name.
> 
>   drivers/pmdomain/tegra/powergate-bpmp.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/tegra/powergate-bpmp.c b/drivers/pmdomain/tegra/powergate-bpmp.c
> index 8cde4f384846..e6a7e025b012 100644
> --- a/drivers/pmdomain/tegra/powergate-bpmp.c
> +++ b/drivers/pmdomain/tegra/powergate-bpmp.c
> @@ -137,6 +137,13 @@ static char *tegra_bpmp_powergate_get_name(struct tegra_bpmp *bpmp,
>   	if (err < 0 || msg.rx.ret < 0)
>   		return NULL;
>   
> +	if (response.get_name.name[0] == '\0')
> +		return NULL;
> +
> +	if (dev_to_node(bpmp->dev) != NUMA_NO_NODE)
> +		return kasprintf(GFP_KERNEL, "%d-%s", dev_to_node(bpmp->dev),
> +				 response.get_name.name);
> +
>   	return kstrdup(response.get_name.name, GFP_KERNEL);
>   }
>   
> @@ -234,7 +241,7 @@ tegra_bpmp_probe_powergates(struct tegra_bpmp *bpmp,
>   		struct tegra_powergate_info *info = &powergates[count];
>   
>   		info->name = tegra_bpmp_powergate_get_name(bpmp, id);
> -		if (!info->name || info->name[0] == '\0') {
> +		if (!info->name) {
>   			num_holes++;
>   			continue;
>   		}

Please let me know if you have any comments on this or if this is OK to 
be picked up now?

Thanks
Jon

-- 
nvpublic

