Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA7D1AD411;
	Wed, 28 Aug 2024 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883463; cv=none; b=ibWd0ekGeSYXPqtKXiNAwG8Z1dh4e5UdzZwKdwHHfrcInZRBI50vPry+mWLqADTSgG7BEnPUSbnV7mY1A9FqmF5SolKJ2gv0KL6ut5HVL8sBcgYHN9PfhS8erAHrc7pgfP6dMQnxVoczuMi7x/FFov5m6wIeEs+MawNSEkst+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883463; c=relaxed/simple;
	bh=58NufC17oHNTIQLxcHe3OwIRzN0rETV+vP2MaMr2KgI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=panGaZU+KwobhZuYHvxAud6PHGsZ0Ha5YpsdzSutantk8tn2h5LvYoYkhnFAyggZrT1BYpgahKYCLoMqMiiHNsRiNDranvZENyVoJMFoxzy4u+sdB82C3U3pa/1vXvZvQyLfzytFsvwkX+QDfJNozZJk2rfD/C7LW4cQJ26iF28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD36AC4CEC9;
	Wed, 28 Aug 2024 22:17:42 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 452CE10604BD; Thu, 29 Aug 2024 00:17:40 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Chen Ni <nichen@iscas.ac.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240710032023.2003742-1-nichen@iscas.ac.cn>
References: <20240710032023.2003742-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] power: supply: cpcap-charger: Convert comma to
 semicolon
Message-Id: <172488346023.466860.16678342111160245545.b4-ty@collabora.com>
Date: Thu, 29 Aug 2024 00:17:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Wed, 10 Jul 2024 11:20:23 +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> 

Applied, thanks!

[1/1] power: supply: cpcap-charger: Convert comma to semicolon
      commit: 50f74b785059453b4f10fe53241c2f612ebf9028

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

