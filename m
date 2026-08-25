Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABE83B1006;
	Tue, 25 Aug 2026 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683718; cv=none; b=VYPZi+KTevmfRtcfzHN4lqQsBre4uprlq9SWh96Osfdvmtt7Uj41sIQUZmdvlW2GK+mXlxdTH3fbqLen+Kx60xe2EAk+BdXtJCBOtfKLOu+SPZOfHvrDIWxJHDMyRlctsfzkQ1U6dKUpovtQNkvkQSdqGQOaO/FHWR2IbYE4CxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683718; c=relaxed/simple;
	bh=VnrPszBSiRoXiiqzr1R5lgTOk3V497w4FLOExBCKc/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVdCey14fsufNTKQIwC9trcG80ZrVzSGnk33L5BTwEh/04GqRpyA8kyYm1YEJzZ1P6uyGLbZ200vpXcDrJOPfIj08E12bD/o/UgcMIQFmdO3+UnhBWyj5o5/N9PmMUi6W65+sF8Y+1XH/AO9aoXuml9hqcgmNtZhAFYTnrwibo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6ulw+K9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6ulw+K9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247891F000E9;
	Tue, 25 Aug 2026 18:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787683715;
	bh=tsb7VVg2qIMV/HWDSklvxBfBGDlyG6uH3/5WhepfegI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z6ulw+K9z6MUB2NVU8BfAZLudfZHhNR75sE99zehhkMekiZ6Wczpiw+g9SLto+e+l
	 p7U91aynY7N7bMPMzXXd/1cEFP6PSzBQITBqOsOxcGQDiUSN8CFjzijn6Tx4d5Aurh
	 mHzY5b/X/8mLHdg9Un+tFV3z8IFQFFEZYjlN1RfnizsR45tgJsbPyCVJnJFvvGvG11
	 wRYuEzX7izolMqRcyUzmJo4Hgn3du2YA6ORznHCXHjqQsX/qX7U7pkPDqTtCWGAi9m
	 aadcsXtjVeaVhxyjr9tT5kbpG21GNngNqLa3lBOw0GfCFeMnEF+B3Sa5+Rr6L8Hh/j
	 TEObcbpvgDrPQ==
Date: Tue, 25 Aug 2026 14:48:25 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux ARM MSM <linux-arm-msm@vger.kernel.org>, amitk@kernel.org,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Linux PM <linux-pm@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: linux-next: Tree for Aug 21
 (drivers/thermal/qcom/qcom-spmi-mbg-tm.ko)
Message-ID: <20260825184825.GA1276817@ax162>
References: <aohvcP8ch-Zn6tV-@sirena.org.uk>
 <580f9129-de4a-472e-bebb-d08d9cabad7f@infradead.org>
 <6027571.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6027571.DvuYhMxLoT@rafael.j.wysocki>

On Tue, Aug 25, 2026 at 03:27:32PM +0200, Rafael J. Wysocki wrote:
> On Monday, August 24, 2026 9:15:16 PM CEST Randy Dunlap wrote:
> > 
> > On 8/21/26 8:32 AM, Mark Brown wrote:
> > > Hi all,
> > > 
> > > Changes since 20260820:
> > > 
> > > None.
> > > 
> > > Non-merge commits (relative to Linus' tree): 7073
> > >  5989 files changed, 509370 insertions(+), 156446 deletions(-)
> > 
> > on x86_64 allmodconfig:
> > 
> > WARNING: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module uses symbol 'devm_iio_channel_get' from namespace 'IIO_CONSUMER', but does not import it.
> > WARNING: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module uses symbol 'iio_read_channel_processed' from namespace 'IIO_CONSUMER', but does not import it.
> 
> Does the appended patch address it?
> 
> Interestingly enough, it doesn't complain for me when I build the
> thermal tree merged on top of the current mainline.

FWIW, I sent a fix for this two weeks ago that explains the semantic
conflict:

  https://lore.kernel.org/20260812-qcom-spmi-mbg-tm-ns-modpost-error-v1-1-d849390d2714@kernel.org/

You will only see it when the IIO tree is merged against the thermal
tree.

-- 
Cheers,
Nathan
