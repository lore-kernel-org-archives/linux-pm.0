From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] opp: no need to check return value of debugfs_create functions
Date: Tue, 22 Jan 2019 11:27:51 -0800
Message-ID: <154818527190.20280.13288000379723139256@swboyd.mtv.corp.google.com>
References: <20190122152151.16139-18-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122152151.16139-18-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Quoting Greg Kroah-Hartman (2019-01-22 07:21:17)
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>=20
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
