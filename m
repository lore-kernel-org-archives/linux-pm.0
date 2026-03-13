Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0106154425;
	Fri, 13 Mar 2026 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773439154; cv=none; b=OEzbH1T8sKl8ds4QR5ok1cG6hxfePqwIrQwzKNCtSz++DLss7QApjWITJe0Lh1wvTZfzlkOYQa/aYbbSL1+4pI8Zml7ZDQll9g1FIdrcFLK9gG9v+v3VBxRji4mVo3WbcjHZSNr1qxwwocpAlIExLAKyRIKvNDj8OHzMcvtFiOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773439154; c=relaxed/simple;
	bh=x9PM5IFvZReHFCTOeGVzjJYOtcV7dXFySyWdsl77Fl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxJU7hBm12X/JmMjEWsBiUozmawLFUs0hN9ldU+1phz9WppiyMXTike7hK5MTn7t3uLVdIlP9v7rDbJIdYdm/A/K2Q7EA5h3I1jk0ILSRBZ/5m1kPDMctaCBVl9nUhYTLxlAzc/CNBgiuEeobyA9FI4yjCe3E1lpcLZbn0UvuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTHTLNwZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTHTLNwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068DFC19421;
	Fri, 13 Mar 2026 21:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773439154;
	bh=x9PM5IFvZReHFCTOeGVzjJYOtcV7dXFySyWdsl77Fl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fTHTLNwZpPvntr1Qcgj/Ivi/CKtH7x8CUyLzeRZOMUb3ESZecHiQhI+diow26hNK9
	 k+rLa2VbQpiH7+gnAvi6uoXHwzkuR2s4+JG2NVC0VJEByQRcddevvSr1up4jcuq5dj
	 lWCFqcNEVOK0zE9b638O/g6N6sZSvFjK2zyz5vAHt09sVG6VNbVP1tKkWnKCT1t4Zd
	 OboA6L4p1rQbuXJ7mzkJIloNh3Wo0Fk9aDaMZBrYkGwxoveKfuxzAQVtWBA2MD5FA6
	 flSbXxNu8v6+riEj8fMmChFeBq1ZJLMj0ZasWOQTlfdF+SUmgsjDuc2vQPzuzfn7b6
	 9aKLys3jZCnPA==
Date: Fri, 13 Mar 2026 16:59:12 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ilia Lin <ilia.lin@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] soc: renesas: Convert to of_machine_get_match()
Message-ID: <20260313215912.GA3415767-robh@kernel.org>
References: <cover.1772468323.git.geert+renesas@glider.be>
 <10876b30a8bdb7d1cfcc2f23fb859f2ffea335fe.1772468323.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10876b30a8bdb7d1cfcc2f23fb859f2ffea335fe.1772468323.git.geert+renesas@glider.be>

On Mon, Mar 02, 2026 at 05:29:11PM +0100, Geert Uytterhoeven wrote:
> Use the of_machine_get_match() helper to avoid accessing of_root
> directly, which is planned to become private.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This is an alternative solution to "[PATCH v2 8/9] soc: renesas: don't
> access of_root directly"
> https://lore.kernel.org/20260223-soc-of-root-v2-8-b45da45903c8@oss.qualcomm.com

Greg applied this, so you'll have to respin on top of that. Next cycle I 
guess. Unless you get him to revert it.

I'm applying the rest of the series.

Rob
