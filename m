Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB2A28CF77;
	Thu,  2 Apr 2026 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145639; cv=none; b=avqCtRQ5jZ6naG80tXJQZmVa/FJ6ROtNldXe8NU4MjCbqdlCsWgUgGKOnQhS8XeWYrsAMCOk1QBQBP0qsDSipHxE13rBfHMyRsTuZJ3klCoesp6gVZT5bLTWWpTJLAF6jkZJFMj81ZJcaJC3igthPRMhdH9Vu4bjc63BfMVFqBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145639; c=relaxed/simple;
	bh=3l87Zv114WGszX1lbArCHdmGrdNnlRC9AdluTFBw9xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pme1Xh6Q2iVdEYuTcBGkIAcUNccZrQwVwZkpi674E6/TYh5SyDK6ZDhfyJ4USEdTvBeRx4tKgRGgQYc9TTcUe620xBod9/Oz2c5z4qZfK9eh4hVnXNDnz4uoTRwjhBh1g0j4YNbNMnBbPslAyEHj6Nyjvsi79Ha6uLXfWAUE3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE0Yc0pE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE0Yc0pE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D58C116C6;
	Thu,  2 Apr 2026 16:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775145639;
	bh=3l87Zv114WGszX1lbArCHdmGrdNnlRC9AdluTFBw9xQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hE0Yc0pE2yNfg6BLuZk7lvsZ9dlO0eXAJRiUalOLKB7J5MOlOddimi5/lEramRh2D
	 tkJ65OcUmSmqZwxjSIuHj4bYTOxROYlTPukIALnlVb2P4RhL8cTTWcxWg7SB++0aPN
	 SJB8vzqShKZMslsU3TwvfJ+YdA3M9JeG8EwUJC/386WXqR6AKvhwOZfV5g3FL07KeX
	 gcLPnaD7NzCwn9ICZ3xLHczNVY4OO0szNfnay1nRvsYi83hASclmINJaEAtyVnAQyb
	 pjrbxYOUlAPMoKn63gxaBjgULVvZVIngT3Znvf4RSNjtIw9O4itvEKhdqYiZx+1fPV
	 15ruRUnCAMG8Q==
Message-ID: <01a921b7-4b8d-4df6-9840-300a8c143e71@kernel.org>
Date: Thu, 2 Apr 2026 19:00:34 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: debugfs: fix devm_kstrdup and kfree
 mismatch
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, akaieurus@gmail.com, me@ziyao.cc
References: <20260318024815.7655-1-hanguidong02@gmail.com>
 <CALbr=LYyNh0AwC+8ni6iS=9UiTyVz9+r_gM7M=ohacCv97ujOw@mail.gmail.com>
From: Georgi Djakov <djakov@kernel.org>
Content-Language: en-US
In-Reply-To: <CALbr=LYyNh0AwC+8ni6iS=9UiTyVz9+r_gM7M=ohacCv97ujOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/2/26 6:42 PM, Gui-Dong Han wrote:
> On Wed, Mar 18, 2026 at 10:48 AM Gui-Dong Han <hanguidong02@gmail.com> wrote:
>>
>> debugfs_write_file_str() uses standard kfree() to release old strings.
>> Initializing src_node and dst_node with devm_kstrdup() creates a memory
>> management mismatch. If a user writes to these debugfs nodes, the
>> devm-allocated memory is freed via kfree(), leaving a dangling pointer
>> in the device resource list that can lead to a double free.
>>
>> Fix this by using standard kstrdup() instead. Since the interconnect
>> subsystem is strictly built-in and cannot be unloaded as a module, there
>> is no exit path requiring manual cleanup of these strings. The error
>> handling path is also simplified by taking advantage of the fact that
>> kfree(NULL) is a safe no-op.
>>
>> Fixes: 8cc27f5c6dd1 ("interconnect: debugfs: initialize src_node and dst_node to empty strings")
>> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
>> ---
>> I noticed this memory management mismatch while working on similar
>> debugfs string initialization fixes [1] recently.
>>
>> [1] https://lore.kernel.org/driver-core/20260317185920.43387-1-hanguidong02@gmail.com/
> 
> Hello Georgi,
> 
> Gentle ping on this patch.
> 
> Just wanted to note that my other related fix has already been accepted [1].
> 
> Could you please let me know if this fell through the cracks, or if
> you have any feedback or modification requests? I'd be very happy to
> address them.

Hello,

Thanks for the patch! I applied it already and it's available in today's linux-next.

Thanks,
Georgi
