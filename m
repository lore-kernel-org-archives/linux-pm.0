Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756568;
	b=ZJDlwmdg1QVZ7/rksaJeHFO5Xb4izfP/TXP2ZxVv1R8rJjFal14fPeEX9VTwQyZqBYu8
	 ZT0OUHkUN6vso02i8y0AvH3iY4P7FFAxbMLhJo1a2u2ZRtJskVOso2Z92ukMcgqUlfimo
	 gqP05JCu2tnoxcDqV1xImV0oSS54DAASmYPaEWD/EtIicJ2mxZdCHzSfcgim+osYl3vZe
	 GN8O/mzZJnDgCy/uXtjyU1ey8FNmE5BSMEMeTdaX6GjNm+BR074+lxkv2cR3+pjrrtE6a
	 8/jeNAkLufd4LK3fAEFe4K2vYP3pbnEN2NR0GdaOuioCp88JrsBOkxBk4dZIV8STtNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756568;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lmSjBt381Int/979ff0RAowhu9l70G3Kq3clcNSHU84=;
	b=zVY1UzYlP0y4n7hNS6p3xg2cwt8ozpyB48fyvJxT4aDoHdRHeEHlMQz8u+BeWwfNcG7p
	 upRyPjJq0T4VqBjCIzOe9R8HZYHO1kj1wL9KCxbnXivgD+cdqsYz+uiD23O9Gk85V2i1Q
	 x0OdEx62s1kIIEVGrMYl3iWDDRoJReNE3L2y6yF1BwWy9Gs/ZEbQr2GTwP6t+wUJeaMQ/
	 Ac7H8Xr35VMx1ID4XnD4PejEIPv7du9RCN2lKxZIOs9r3UjILFbWW7U5jD3o9D6IOP5GG
	 VQAh38nMguEuoya7vKb2ziyhm9TCfGzxyjC1qp4Mq5P5BdtydiVXz72D1uhu8fkX3gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D811BYcD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077CA606A334;
	Sun, 15 Nov 2026 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D811BYcD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF951F000C6;
	Sun, 15 Nov 2026 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794756567;
	bh=lmSjBt381Int/979ff0RAowhu9l70G3Kq3clcNSHU84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D811BYcDDRLTH3539BYRUTk5+jW0pBswaX1c5SI6ChVwbLISbzomaIEdyzFlgiayf
	 NPq8KnoYoHtSh4np4un13lyoLfpSlFll47pk/Zt0bwKkOrXYl7xt2rYtdrYSArr4z9
	 26fwknIIo/06kDhgvren3SidxbdEwBFeWA/8nStIV/WUiQURGvNxzVjbYw0wUSnISL
	 rXMH+gD5nJHNfxkxhehVmBiJl08NT2Z7b1NkDXbUFENpdjOng+Kerz+eWMZcB9UOAM
	 gEW9pzKy6tzgDssoI2FSb8goaph5F+1GEEfnY5k6cGPJ4vTLsHrJnrfziKgv9L/CKw
	 uLmUex2ZvnXaA==
Date: Sun, 15 Nov 2026 05:29:26 -1000
Message-ID: <fbe6a1b7e8ada40e4f5ace07703ab631@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Samuel Wu <wusamuel@google.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-pm@vger.kernel.org, kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Skip non-freezable workqueues in freeze and thaw
In-Reply-To: <20261115002915.1849847-2-wusamuel@google.com>
References: <20261115002915.1849847-2-wusamuel@google.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Applied to wq/for-7.5.

Thanks.

--
tejun
