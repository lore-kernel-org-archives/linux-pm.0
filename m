Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6445421229;
	Mon,  3 Aug 2026 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779563; cv=pass; b=I3ux8LD5lYU+fpvwVLrAROUQSPaqga1xAAcpToHgqinN7hZXbYze7giBNHh+8MOJHQkJGogIXHRCnH3L/4sVXpcaFHatTYS2GchXRivWvBu03J13RCnbAvMQQmJvAG7V8CltvC8tzkE2VD/sm4CwuRXMrxcMhwbqo5Tqh+JSiT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779563; c=relaxed/simple;
	bh=LgTKGDhVQgNvHdHnSr5GOcNOPJZ0YP61csvj8tL8CEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mf6xPwbpuuPRkCA+UNXmgfvC2gU8qYr2uPqbgS8Iw9OToliTWUDXZWRYVJn0ZMGQiTjg/ADahvXOV+9Ll6Uq/YIklthYWXGpncvXOANySHveOLK8A07C7WGpWlw53ihtW0Tz9lFoH1avHagdXawQ7Sc3UfRaBrP++7lJX7KJ/VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=TV+MF4Bo; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="TV+MF4Bo"
ARC-Seal: i=1; a=rsa-sha256; t=1785779548; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=g59yyC8DqdSbm70iZtBoGkaOA1hltQ8tFQcPe7Hg4sB22ccaz+eLAhwaw+iKnLHj7A0xIx5fFaw9I4CUrwj22HAc4rYsczZcAfHF38MdWz/j1YUZ2amZTApNt3r1thaGKa0PSK6AngjCdkHaR9Qt67PperoJC+aQDyrp8JS6w04=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785779548; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0Mts8ll6+oxRamQDpr6mP72s4sDRnxuiwxxHZSDTndI=; 
	b=kmYFuc0SMYf4YkaffwD6JGk9nXNDn4ZSr/nLegFsL0Ri6lBItd7qiuxiNMHVeZLoBKIGYAWby1BCTOtVOiccuLs9Oea/VNb5qNy+s3HkkGSHPQIUwkID7LtkOeu5XjtS1e8aC/n058POCspeMwMpDKjYhinsbFSwxxD+TB4+uh8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785779548;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0Mts8ll6+oxRamQDpr6mP72s4sDRnxuiwxxHZSDTndI=;
	b=TV+MF4BoVc+5yDa/vSWgeyTGHtd9qUo5nkLKE6td/1QoCrJSg+1skZuH7p+9lLza
	O5qf/LmU/cpi9USjadGdUTJ5bD0UOgGSr2N5QVeMtlaUjv6G3LJ2qgj3PyjeMsZVan+
	8bCznVAH5CffzCfCmuaTQflh/6nEquNgVJxAHNd4=
Received: by mx.zoho.eu with SMTPS id 1785779544801642.1066758225967;
	Mon, 3 Aug 2026 19:52:24 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B . Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] cpupower: fix topology array handling
Date: Mon,  3 Aug 2026 17:52:06 +0000
Message-ID: <20260803175215.117518-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

v1 did two things in one patch. Shuah asked for them to be split, so here
they are as two.

Patch 1 is the uninitialized read: get_cpu_topology() allocates core_info
with malloc(), several paths never write core_cpu_list, and the sort
comparator then hands that buffer to strcmp(). calloc() fixes it.

Patch 2 is separate and only about the physical core count. The counting
loop seeds cores at 1 from entry 0 without checking whether that entry has
usable topology data, so an incomplete entry can be counted as a core.
Patch 2 depends on patch 1, since it uses an empty core_cpu_list to
recognise an entry that was never filled in.

Tested against a fake sysfs tree with the configured CPU count pinned to 2,
where cpu0 has complete topology and cpu1's topology attributes are absent.
Same harness, one commit apart:

  unpatched     cores=2   valgrind: errors
  patch 1       cores=2   valgrind: clean
  patch 1+2     cores=1   valgrind: clean

Unpatched, valgrind traces it to the allocation:

  Conditional jump or move depends on uninitialised value(s)
     at strcmp (vg_replace_strmem.c:941)
     by __compare_core_cpu_list (cpupower.c:159)
     by qsort_r (qsort.c:409)
     by get_cpu_topology (cpupower.c:214)
   Uninitialised value was created by a heap allocation
     at malloc (vg_replace_malloc.c:446)
     by get_cpu_topology (cpupower.c:174)

I have no machine where a topology attribute actually disappears during
enumeration, so the fake tree is as close as I could get. If you would
rather see this exercised some other way, say so and I will do that.

Link to the v1 review:
https://lore.kernel.org/all/c746110c-6ac4-4500-a4f0-491a06838173@kernel.org/

Ali Ahmet Memis (2):
  cpupower: zero the topology array to avoid uninitialized reads
  cpupower: do not count incomplete topology entries as physical cores

 tools/power/cpupower/lib/cpupower.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
2.55.0

