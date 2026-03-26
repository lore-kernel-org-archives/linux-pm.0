Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4079376464
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535755; cv=none; b=A5jCtcHCzb2wrgF7adE+hCiqpJwL5oSskQasMz2BY8NjmzFsI7qLe3zxIBx11Lg+Zy/na/N6ofaMBtJ/TjqA7mwCLIJ7yMzsQFXyTsJ2MeQJBgnDuDnEUzz0OJMQdlXr7umlh2Ifbn3fBSLLHngO1ZfM76KxBL2slBG4rw5xgUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535755; c=relaxed/simple;
	bh=QZDlQYeC61OjveD2+3ErtzdC3Vl442TCwTYJVRTPKX8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=si+vjvtV2dWYCHfKSprcLt5jPBq9QWzsLThJzE13UDhw8fu33XMtca+at7lCQm0BPGwhy5Y+f2dTdh8lkk8+NHFBRP0GwqFXew6H6REZ7Msg8N5Yj7YTZ31JNJyrYJJk6FRpFz5wH1/EscpvUBTUzPR21baMOeF9k0r1if3vBqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzhonhkI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzhonhkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A22FC19423
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 14:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774535754;
	bh=QZDlQYeC61OjveD2+3ErtzdC3Vl442TCwTYJVRTPKX8=;
	h=From:Date:Subject:To:Cc:From;
	b=DzhonhkITB/2Y4aO/C4PqTLuVckwMsRQNcAw3OOD4NNWZ5ZOdl1TggiznZLZgtfKL
	 Xd3grZyozW2JjFdaxGMhBSeQRd62VGT0iTvzqyM4ZCywGyaShtnZAGU8U4dWw7cz+X
	 KWEUfdfrl0xI4YXqJs3Y+hMD9w9ItzUJ87k5iDW82f+YK2HaNM2Clp/JnYfnjH4XUx
	 TCXeMDX2X7ibXdT1cZcNnBJsxhUloVooDrE0ZDokjHdygJg4q9L/BYrOkCz/2FKbzn
	 +wRWNfPAaSlC3D1TvoQ4SDi9cV9GJObhUF27eVB9LWso3GHQAklduL1Hi2FvUJc+VH
	 CXEJMPvKn0wFQ==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-679f6ee3fb0so454292eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 07:35:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YwA/PXNPttuItqn1D+14efBJMhxrRIY6KEnJUdXYgpkrdRrH7J+
	O9etGCu2Mc2bGXnGgaNmFLgk0qZYor086SXHN0aPeAeawDNDzHrWj4uMwr5+afxs0Ajp7wnPn6E
	Xq7brlzI6m0V05+e446dzqkEh53w5W7M=
X-Received: by 2002:a05:6820:1625:b0:67d:eeb7:4778 with SMTP id
 006d021491bc7-67dff47880bmr3866877eaf.32.1774535753568; Thu, 26 Mar 2026
 07:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Mar 2026 15:35:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jp-xWc_7Njjsva3EBhJXM31XVBpSspSkTd7FJ0wz1ezQ@mail.gmail.com>
X-Gm-Features: AQROBzDbkKpIq8By9nzshDExoO0brLASXfBeS4df3z8uI2_2cy4Zb9nKb6pUrQI
Message-ID: <CAJZ5v0jp-xWc_7Njjsva3EBhJXM31XVBpSspSkTd7FJ0wz1ezQ@mail.gmail.com>
Subject: [Pre-CfP] LPC2026: Power management and thermal control micro-conference
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Morten Rasmussen <morten.rasmussen@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Christian Loehle <christian.loehle@arm.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Pierre Gondois <Pierre.Gondois@arm.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi All,

I'm looking for topic suggestions to be included in the power
management and thermal control micro-conference submission for
LPC2026.  The deadline for submitting LPC u-conf proposals is April
23, so if there are any topics you'd like to be covered, please let me
know within the next 2 weeks.

Thanks, Rafael
