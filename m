From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] cpufreq: Reformat printk() statements
Date: Tue, 11 Mar 2014 10:16:52 -0700
Message-ID: <1394558212.21085.57.camel@joe-AO722>
References: <1394557380-15054-1-git-send-email-soren.brinkmann@xilinx.com>
	 <531F441C.5070107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <531F441C.5070107@gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2014-03-11 at 10:13 -0700, Dirk Brandewie wrote:
> On 03/11/2014 10:03 AM, Soren Brinkmann wrote:
> > From: Joe Perches <joe@perches.com>
> >   - Add missing newlines
> >   - Coalesce format fragments
> >   - Convert printks to pr_<level>
> >   - Align arguments
> This introduces a bunch of lines over 80 charaters long.

Intentionally.

from: Documentation/CodingStyle

		Chapter 2: Breaking long lines and strings

Coding style is all about readability and maintainability using commonly
available tools.

[]

never break user-visible strings such as
printk messages, because that breaks the ability to grep for them.


