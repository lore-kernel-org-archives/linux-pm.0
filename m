From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 10/79] docs: cpu-freq: convert docs to ReST and rename
 to *.rst
Date: Tue, 23 Apr 2019 10:21:59 +0200
Message-ID: <CAJZ5v0it3JfAZu8=4_m996JGjSRC6DLfRNYd6KrszB10-U2Fig@mail.gmail.com>
References: <cover.1555938375.git.mchehab+samsung@kernel.org> <90ab7c100b7fb0120689ebeda5d13447b2cb2af8.1555938375.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <90ab7c100b7fb0120689ebeda5d13447b2cb2af8.1555938375.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 22, 2019 at 3:36 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> The conversion is actually:
>   - add blank lines and identation in order to identify paragraphs;
>   - fix tables markups;
>   - add some lists markups;
>   - mark literal blocks;
>   - adjust title markups.
>
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.

Well, as stated before, please drop this one too.

There is a plan to convert the remaining cpufreq documentation into
.rst (and which has already been done for the admin-guide part) and
the resulting files should go into driver-api.

Thanks,
Rafael
