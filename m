From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] PM / OPP: Add support for descending order for
 cpufreq table
Date: Mon, 5 May 2014 20:08:45 +0530
Message-ID: <CAKohpokfcptseU6ST+e_GfU6poVJxXCXMeoYCvT65060v5GJYQ@mail.gmail.com>
References: <000001cf643d$69e5e350$3db1a9f0$@samsung.com>
	<CAOh2x=m8DzmLOGqL0E_seOZMuzU=O9vQuu-JEp+E5454RmfEXw@mail.gmail.com>
	<003901cf6664$e4e8d2a0$aeba77e0$@samsung.com>
	<CAKohpon7W726Hxj5OJ6SnmPz3gYhAeBRr1wS3SCa3F2hSLriLQ@mail.gmail.com>
	<5367946F.1030407@ti.com>
	<CAKohpon-KZpSJK7PxpLjZS7sVPcYraDxb4oJHN6dxSagD+F--Q@mail.gmail.com>
	<CAGo_u6pUVeMM9mqe5htvM1X_4pkRGEUVOA2ty4ZPfUyLcLZkrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGo_u6pUVeMM9mqe5htvM1X_4pkRGEUVOA2ty4ZPfUyLcLZkrw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Jonghwan Choi <jhbird.choi@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 5 May 2014 19:53, Nishanth Menon <nm@ti.com> wrote:
> ceil and floor allows us to walk down the opp entries the direction we
> want it to.
> one can convert that data any way one wants it - especially when custom
> mapping such as this is desired.

Yeah, but doing that for every frequency transition is not right.
Otherwise they already have a solution, where they reverse order
of frequencies for their driver. exynos_sort_descend_freq_table().

Probably that's a better solution then :)

But, Jonghwan was probably trying to get this solved in the framework
only, in case anybody else needs it.

--
viresh
