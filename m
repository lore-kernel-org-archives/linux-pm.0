Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E4422A4F1;
	Thu, 12 Mar 2026 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337813; cv=none; b=pQUqQpvJNoncR4jqI6UFqfRvusQ8yCbsJn2AWdH2+7evhXKGw2pUudyrmk7jo9DzdNyDPmJnug6MIhVBP6FDb0mAvXlQE/jmZTzat0SecSBJdXWLtuWjLVXycdpBXU6cYnwyWoTMXkNY8hBeHpqDoqoOhr+3lGcRQTduxCzONzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337813; c=relaxed/simple;
	bh=TD54IZlH1Y0ImBCJDVtOWWnfNCKfC9SghmImji/+c+w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qIIRLWm7SWgF5753kc7RWgroDAwyNZqhPDHjVEqXXKJeuAHPk4WmS5Oo87VO9u+7MPkciUdDFSvp7vqTX67hWAO1wtidIctPoMYaZVCGB1mZTQcwMldkbrLyz19B3S3xPScWLG45DEqVHcCeTTZp+sQB8IX6mztJwbzh580J7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qs8EYWHc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qs8EYWHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8709C4CEF7;
	Thu, 12 Mar 2026 17:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773337812;
	bh=TD54IZlH1Y0ImBCJDVtOWWnfNCKfC9SghmImji/+c+w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qs8EYWHc0SzLOhqEQO1tQ2w6I4Km8bJ/CzFsBMdJl6wROuAP4QhDLoREAGjq1jMeV
	 VldxuXm7k3Bw85Vpa6uMIyIXKj0+60G+UHsgoWbub/SjtIddzQ5abQqMajvNeArAmi
	 YO0l0i0doE444V7M9WKvJb820zsgc9Ah/qhBclAjypqA2yTeQQEJmZs2X0YskA+ibo
	 UfRywAKmC5TX+XWaFQVqPyVNXVvzMIMC8zFCAT593tkE3eIbXhHipbQlvCh+tZtFKa
	 gVpZioPeWECGMTVYhU4dKwKhUFNCLYAsaLZZav9gckcWWcI+svOEGtGqn/fQPBhhI2
	 22eQnOAteSj2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D4003808200;
	Thu, 12 Mar 2026 17:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] Bluetooth: extend WCN driver to support WCN399x
 device
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177333780829.19812.5577536348668835963.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 17:50:08 +0000
References: <20260311-wcn3990-pwrctl-v4-0-70e571a18e40@oss.qualcomm.com>
In-Reply-To: <20260311-wcn3990-pwrctl-v4-0-70e571a18e40@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: brgl@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
 marcel@holtmann.org, luiz.dentz@gmail.com, mka@chromium.org,
 quic_bgodavar@quicinc.com, c-hbandi@codeaurora.org,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 bartosz.golaszewski@oss.qualcomm.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Mar 2026 01:02:56 +0200 you wrote:
> Qualcomm WCN3950, WCN3988 and WCN399x families of WiFi/BT chips preceed
> the later WCN / QCA devices, but they still incorporate a very simple
> PMU on die. It controls internal on-chip power networks, but, most
> importantly, it also requires a certain start-up procedure (first bring
> up VDD_IO, then bring up other voltages). In order to further unify code
> supporting different families of QCA / WCN chips and in order to
> maintain the required power up sequence, properly represent these chips
> in DTs and modify drivers to use power sequencing for these chips.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] Bluetooth: qca: fix ROM version reading on WCN3998 chips
    https://git.kernel.org/bluetooth/bluetooth-next/c/77a65e88b9b8
  - [v4,2/2] Bluetooth: qca: enable pwrseq support for WCN39xx devices
    https://git.kernel.org/bluetooth/bluetooth-next/c/a529ecf9f12c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


