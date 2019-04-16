From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 09/57] docs: cpu-freq: convert files to ReST
Date: Tue, 16 Apr 2019 10:21:31 +0200
Message-ID: <CAJZ5v0he8GHZ+EFJ911vgrO53NnEWDwm=_vZD4K9SVL0MahMTQ@mail.gmail.com>
References: <cover.1555382110.git.mchehab+samsung@kernel.org> <b2f9cc0d15d7e3058be01015be36f698debd8b14.1555382110.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b2f9cc0d15d7e3058be01015be36f698debd8b14.1555382110.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 16, 2019 at 4:56 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> In order to be able to build html and pdf files, convert the
> documentation to ReST format.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Please don't convert these files.

They need more work than just semi-automatic conversion and the
material in them needs to go under driver-api.

This is quite hight in my TODO list.

Thanks,
Rafael
