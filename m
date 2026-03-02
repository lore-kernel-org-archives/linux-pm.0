Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F2B33CEA7;
	Mon,  2 Mar 2026 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772494920; cv=none; b=U+g11jHEbXUkl+QN79eIU7priseXTtpnv1wwmM6dRBKkSoJSYcrTGWdJffqpbJbMaGCct5Eo0u/LScdh0B02tkDUDS9tjq4aYZ0EUWlnrOFq2uTtlsHp000XDivavT6klhlhQwKFb2sFzMLkXfCxlbJwE5lLGfbiCAhZhFdlhv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772494920; c=relaxed/simple;
	bh=4zHGyQPVsoBJd3grC9Pvjo/np6QeDvcXiqyuRWMBKA4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rqCGGxF9tlg8Dl+MPMDlT0BpYcQHM6skB0VX5vEgB8KTtEOL4ntFAlxTrYxuO9gdJab7liE55NtrlsnHq9ZQJlQlSAxavPBAoIOA50loF/qy0LJIOpRBH5fhfFPyTL05l0fQD8HAKTAZ9BYapvYZNLGX3vaHvvaugeeZKGcX+8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14A7C19423;
	Mon,  2 Mar 2026 23:41:59 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 247D2180D08; Tue, 03 Mar 2026 00:41:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Jaime Saguillo Revilla <jaime.saguillo@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260219212353.49416-1-jaime.saguillo@gmail.com>
References: <20260219212353.49416-1-jaime.saguillo@gmail.com>
Subject: Re: [PATCH] power: supply: cpcap-battery: fix typo in config name
Message-Id: <177249491813.606802.6689179976776460463.b4-ty@collabora.com>
Date: Tue, 03 Mar 2026 00:41:58 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 19 Feb 2026 21:23:53 +0000, Jaime Saguillo Revilla wrote:
> Rename cpcap_battery_unkown_data to
> cpcap_battery_unknown_data to correct a spelling mistake
> in the identifier.
> 
> No functional change.
> 
> 
> [...]

Applied, thanks!

[1/1] power: supply: cpcap-battery: fix typo in config name
      commit: 3feb95a8e9e54fa9f0cf01652d0edc3a7def0857

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

