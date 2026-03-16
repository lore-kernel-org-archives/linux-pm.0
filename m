Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB7399004;
	Mon, 16 Mar 2026 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667913; cv=none; b=oLZrcCF/KFce7WfmZ+jBoVa85VMxkbY9GVaUemUd8xiOAnDBtJlIXdjGngAZCw+9UUMfV1p64kLoBNZZOfysYUbfd6RLJziaHhIez7orBhW9ur2SYh6v+SmJvyeNYAt3cDtRC2Z+AwkJGvERV3Ge0A7p824kJDoe1gVFJ5eJCKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667913; c=relaxed/simple;
	bh=euP2VlB16+h3+tDAsvA2AIisuNXAJaozOZ7q/lSTC6s=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=BFd3gfr03O3GI19TrsreINAvqlTxScBz6g+UeE/G8xmBd2PL7TeIeCvdoT8wAQM9I16yhgV7DNNW3zOViCT4wYB+9z/2LxywXSBXPLzZlxz/K2x0LL+n4l6xGYz3SSknlUf1mvnxlan/JJld0tPSKqDfOxSg3Kq4XCbSWH2PsMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ74LV43; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ74LV43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8DEC19424;
	Mon, 16 Mar 2026 13:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773667912;
	bh=euP2VlB16+h3+tDAsvA2AIisuNXAJaozOZ7q/lSTC6s=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=gJ74LV43TgGEJ+FFJqdPZNXXnSOJNymST9mbbWKDWkXN/sg3Dtn8QcSJnXxcKtUTR
	 ux0uoSwi+68llze0eNEFlW1WSpkfLfHevYS5C709drZ85Trfl8YzlzR84MPj9AFayp
	 ILsBxBOFvZQktQspbeAmoNUEY/298GQsFirDGqJxG1s2zzFwepKCHrI+IL1TsyS7Q/
	 DtRJnBCePMlkXLZFsxmABqQZcyGdhL9LhyXVGFyFd9sGVSw0jgRubZg82i9F30cDes
	 DvCJrNLhn6CqIQvx+qZzS5mBtp9bTrmVuCDrs2bK59PO8rn9NpKseo6GwchZVGVMeG
	 3eHLFT3qf7VWg==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 13:31:48 +0100
Message-Id: <DH47IUOY0Q9T.JKDPRZV6PSCP@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [RFC PATCH] rust: kbuild: support global per-version flags
Cc: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <bjorn3_gh@protonmail.com>, <boqun@kernel.org>, <gary@garyguo.net>,
 <jhubbard@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <lossin@kernel.org>, <rafael@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <tmgross@umich.edu>,
 <viresh.kumar@linaro.org>
To: "Mark Brown" <broonie@kernel.org>
References: <CANiq72mWdFU11GcCZRchzhy0Gi1QZShvZtyRkHV2O+WA2uTdVQ@mail.gmail.com> <20260307170929.153892-1-ojeda@kernel.org> <CANiq72=drAtf3y_DZ-2o4jb6Az9J3Yj4QYwWnbRui4sm4AJD3Q@mail.gmail.com> <abdJE4BsrzGDTVZT@sirena.co.uk> <CANiq72nXMbP2ZbyNE6voWXrEXg85s99pXLj5LeybZry4eAyzEQ@mail.gmail.com> <ffd14e81-c64e-42fa-aa18-60c8036f13e8@sirena.org.uk>
In-Reply-To: <ffd14e81-c64e-42fa-aa18-60c8036f13e8@sirena.org.uk>

On Mon Mar 16, 2026 at 1:50 PM CET, Mark Brown wrote:
> On Mon, Mar 16, 2026 at 05:49:02AM +0100, Miguel Ojeda wrote:
>> On Mon, Mar 16, 2026 at 1:04=E2=80=AFAM Mark Brown <broonie@kernel.org> =
wrote:
>
>> > At the minute whatever linux-next runs is whatever Debian stable has!
>
>> Great, that would mean we are effectively keeping the minimum one
>> clean, which is in a way the best we can do (apart from the maximum)
>> if we don't try to keep every single version clean between them.
>
> Note that I've not started running with clippy yet, currently due to
> Linus' tree having:
>
> error: current MSRV (Minimum Supported Rust Version) is `1.78.0` but this=
 item is stable since `1.79.0`
>   --> /tmp/next/build/rust/kernel/ptr/projection.rs:79:26
>    |
> 79 |         if self >=3D slice.len() {
>    |                          ^^^^^
>    |
>    =3D help: for further information visit https://rust-lang.github.io/ru=
st-clippy/master/index.html#incompatible_msrv
>    =3D note: `-D clippy::incompatible-msrv` implied by `-D warnings`
>    =3D help: to override `-D warnings` add `#[allow(clippy::incompatible_=
msrv)]`

Interesting, I neither see this with 1.78.0 nor 1.94.0, but I can indeed
reproduce this with 1.85.1.
